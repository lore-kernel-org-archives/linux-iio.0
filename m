Return-Path: <leonard.crestez@intel.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [RFC] iio: Add support for describing scan offsets in buffer ops
Cc: Daniel Baluta <daniel.baluta@intel.com>
Message-ID: <5728A9B5.6080902@intel.com>
Date: Tue, 3 May 2016 16:37:57 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Hello,

This is a tentative proposal with no code attached. This issue came up
while hacking on the mpu6050 driver but it applies to other complex
devices and a solution belongs in the IIO core.

One IIO limitation is that while samples can be described through a
relatively generic scan_type they must be placed in the output buffer
according to an specific iio alignment algorithm. For example if the
device has one 16bit channel and one 32bit channel the output needs to
have 16bits of padding between them. When this does not match the
hardware format the solution is for the driver to unpack the hardware
samples and repack them in the iio format.

I propose that we add a new function in iio_buffer_setup_ops which looks
like this:

int (*get_scan_offsets)(struct iio_dev *indio_dev,
                        off_t *scan_offsets,
			size_t *sample_bytes);

This would be called when enabling a buffer to fetch the offset in the
sample for each channel (by scan_index) based on the currently
configured scan mask. Then the iio core would then handle rearranging
sample bytes as expected by the buffer consumer. Driver implementations
could look something like this:

off_t pos = 0;
if (scan_mask & (1 << SCAN_INDEX_TEMP))) {
    scan_offsets[SCAN_INDEX_TEMP] = pos++;
}
/* No 2-bytes alignment here! */
if (scan_mask & SCAN_MASK_ACCEL_ANY) {
    scan_offsets[SCAN_INDEX_ACCEL_X] = pos + 0;
    scan_offsets[SCAN_INDEX_ACCEL_Y] = pos + 2;
    scan_offsets[SCAN_INDEX_ACCEL_Z] = pos + 4;
    pos += 6;
}
*sample_bytes = pos;

This could be implemented as an extension to the current buffer demuxing
support which currently only deals with differences in scan_masks. This
mechanism would very nicely deal with devices where it is not possible
to select X/Y/Z individually because the iio core would just ignore the
gap in offsets.

This can even be exposed to userspace in a compatible manner. User would
do something like:

    ioctl(iio_fd, IIO_USER_HANDLES_SCAN_OFFSETS, 1);
    ioctl(iio_fd, IIO_GET_SCAN_OFFSETS, &scan_offsets, &sample_bytes);

When the consumer is marked as aware of scan offsets this way the iio
core can skip demuxing for increased performance. The IIO core can
implement IIO_GET_SCAN_OFFSETS itself when the driver has no custom
implementation. An application could rely on IIO_GET_SCAN_OFFSETS for
all devices as long as it's acceptable to ignore old kernels.

This would be particularly useful if IIO sample buffers are
memory-mapped eventually. I think that this extension would be
incrementally useful to that effort.

-- 
Regards,
Leonard
