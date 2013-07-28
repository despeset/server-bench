#include <inttypes.h>
#include <stdio.h>
#include <stdint.h>

#if defined(__APPLE__)
	#define USING_MACOSX
#endif
#if defined(__GNUC__) && !defined(USING_MACOSX)
	#define USING_LINUX
#endif

int main(void)
{
	#if defined(USING_MACOSX)
		#include <mach/mach_time.h>
		uint64_t t = mach_absolute_time();

		// Get ratio between mach_absolute_time units and nanoseconds.
		mach_timebase_info_data_t data;
		mach_timebase_info(&data);

		// Convert to nanoseconds.
		t *= data.numer;
		t /= data.denom;
		t /= 1000;

		printf("%" PRIu64 "\n", t);
	#endif
	#if defined(USING_LINUX)
		#include <sys/time.h>
		struct timeval tv;
		gettimeofday(&tv, NULL);
		double time_in_mill = (tv.tv_sec) * 1000 + (tv.tv_usec) / 1000;
		printf("%f\n", time_in_mill);
	#endif
        return 0;
}
