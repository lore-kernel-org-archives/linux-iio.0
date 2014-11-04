Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:42249 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbaKDIhX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Nov 2014 03:37:23 -0500
Received: by mail-wi0-f177.google.com with SMTP id ex7so8564070wid.10
        for <linux-iio@vger.kernel.org>; Tue, 04 Nov 2014 00:37:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1415089663.4506.26.camel@hadess.net>
References: <1414593052.2406.37.camel@hadess.net>
	<5451221D.6000301@metafoo.de>
	<1414604035.2406.41.camel@hadess.net>
	<54512640.3040505@metafoo.de>
	<1414604840.2406.43.camel@hadess.net>
	<54513238.6050903@metafoo.de>
	<1415055709.4506.19.camel@hadess.net>
	<CAEnQRZAA7bN999XUmj3kaH2U3dPET0NRXDcFNprxZLAZS=ARzg@mail.gmail.com>
	<1415089663.4506.26.camel@hadess.net>
Date: Tue, 4 Nov 2014 10:37:21 +0200
Message-ID: <CAEnQRZBoTbQMCC1+qwewUefk1u616pLrhUD+i5WhoZ0Se+2fWQ@mail.gmail.com>
Subject: Re: Kernel wishlist item: Better IIO API
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Nov 4, 2014 at 10:27 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Tue, 2014-11-04 at 10:18 +0200, Daniel Baluta wrote:
>> On Tue, Nov 4, 2014 at 1:01 AM, Bastien Nocera <hadess@hadess.net> wrote:
>> > On Wed, 2014-10-29 at 19:30 +0100, Lars-Peter Clausen wrote:
>> >> On 10/29/2014 06:47 PM, Bastien Nocera wrote:
>> >> > On Wed, 2014-10-29 at 18:39 +0100, Lars-Peter Clausen wrote:
>> >> >> On 10/29/2014 06:33 PM, Bastien Nocera wrote:
>> >> >>> On Wed, 2014-10-29 at 18:21 +0100, Lars-Peter Clausen wrote:
>> >> >>>> On 10/29/2014 03:30 PM, Bastien Nocera wrote:
>> >> >>>>> Hey,
>> >> >>>>>
>> >> >>>>> I've posted this a couple of days ago:
>> >> >>>>> http://www.hadess.net/2014/10/a-gnome-kernel-wishlist.html
>> >> >>>>> along with a mail to LKML:
>> >> >>>>> http://thread.gmane.org/gmane.linux.kernel/1810083
>> >> >>>>>
>> >> >>>>> I've recently added to my list an item about IIO:
>> >> >>>>> https://wiki.gnome.org/BastienNocera/KernelWishlist
>> >> >>>>>
>> >> >>>>> Are there any plans for a better API for the IIO subsystem? The API
>> >> >>>>> might be good enough to drive from shell scripts, or helpers that only
>> >> >>>>> need to work with one variant of a device, but my attempts at trying to
>> >> >>>>> use the IIO subsystem to provide an accelerometer to do automatic
>> >> >>>>> display rotation[1] showed that the API is really cumbersome.
>> >> >>>>>
>> >> >>>>> The code I wrote spends most of its time creating sysfs paths, reading
>> >> >>>>> values in different formats, and mangling filenames[2].
>> >> >>>>>
>> >> >>>>> Is an ioctl-based API planned? Something where I could get/set
>> >> >>>>> structures to gather metadata about the device, and set it up easily, so
>> >> >>>>> reading data from it is easier?
>> >> >>>>
>> >> >>>> No, unfortunately not and I'm not sure if such a ABI would be accepted if
>> >> >>>> proposed.
>> >> >>>
>> >> >>> Why not?
>> >> >>
>> >> >> Because it means there will be ambiguity in the API on how to do things.
>> >> >> Which is typically not a desired property.
>> >> >>
>> >> >>>
>> >> >>>> But checkout libiio[1][2], it hides the details of the sysfs file manipulation.
>> >> >>>
>> >> >>> I'm not sure that's any better unfortunately. I've certainly tried to do
>> >> >>> that already in my code, but that doesn't change that the user-space API
>> >> >>> is barely usable.
>> >> >>
>> >> >> It's not completely unusable ;)
>> >> >
>> >> > In the end, you prefer the "self-documenting" of using sysfs files,
>> >> > rather than an API which you can document in a header file?
>> >>
>> >> If it was for me we'd be using a state-full IOCTL ABI rather than a
>> >> stateless sysfs ABI. I'm definitely not happy with the current interface,
>> >> but it's the interface we have. But the problem with userspace ABI (in
>> >> comparison to in-kernel API) is that we can just change things at random,
>> >> but we have to stick with the existing interface.
>> >>
>> >> The sysfs ABI is not meant to be self documenting and it is not
>> >> undocumented. The documentation for the different attributes can be found in
>> >> Documentation/ABI/testing/sysfs-bus-iio[1].
>> >
>> > That's useful if a bit terse. Thanks though.
>> >
>> >> > I don't understand that. My questions on this very mailing-list, and
>> >> > comments that were made to users of my code[1] clearly show that the
>> >> > existing API is anything but "not ambiguous".
>> >>
>> >> That bug report sounds like bugs in the driver.
>> >
>> > Not really. Some drivers need the "in_accel_hysteresis" set, some don't
>> > have that sysfs file, for example.
>> >
>> >> > I've used the Bluetooth, input, rfkill, and inotify APIs as provided
>> >> > directly by the Linux kernel (not through a layer) and they're of better
>> >> > quality than the IIO one.
>> >> >
>> >> > I just don't see how one could support a class of IIO sensors with the
>> >> > existing API.
>> >>
>> >> I can understand your frustration. A API that is not usable in a generic way
>> >> is not really useful. So we should try to fix that, but we are bound by the
>> >> framework itself and can't just throw everything away.
>> >>
>> >> So lets start by trying to identify what is missing. Which information do
>> >> you think could be provided by using a IOCTL interface which you need or
>> >> want which is not provided by the current sysfs interface or can not be
>> >> provided by the current sysfs interface.
>> >
>> > (pseudo code ahead)
>> >
>> > First, being able to cut down on the string manipulation would be great.
>> > So instead of doing:
>> > accel_x_path = build_filename (sysfs_path, "in_accel_x_raw");
>> > accel_y_path = build_filename (sysfs_path, "in_accel_y_raw");
>> > accel_z_path = build_filename (sysfs_path, "in_accel_z_raw");
>> > if (exists(accel_x_path) && exists(accel_y_path) && exists(accel_z_path)) {
>> >   // We have an accelerometer
>> >   do_something();
>> > }
>> > free(..x);
>> > free(..y);
>> > free(..z);
>> > free(sysfs_path);
>> >
>> > I could query for the device's capabilities:
>> > fd = open ("/dev/iio0");
>> > ioctl(fd, IIO_GET_CAPS, &caps);
>> > if (caps.channels & (IIO_CAP_ACCEL_X | IIO_CAP_ACCEL_Y | IIO_CAP_ACCEL_Z)) {
>> >   // We have an accelerometer
>> >   do_something();
>> > }
>> >
>> > Note that, from the data given, I don't know how to make out whether
>> > something is an accelerometer, or a quartenion sensor, or which one we
>> > should prefer on specific machines.
>> >
>> > This would also be stateful, so that 1) enabling the various channels,
>> > 2) changing the hysteresis would be reset when the fd is closed. That
>> > would cut down on the power consumption when unused, or when the service
>> > that uses that data crashes.
>> >
>> > Finally, there's some documentation, and it's not quite finished, or
>> > there's something fishy on this device:
>> > $ ls /sys//devices/platform/80860F41:04/i2c-12/i2c-SMO8500:00/iio:device0/events
>> > in_accel_x_thresh_thresh_en      in_accel_x_thresh_thresh_value
>> > in_accel_y_thresh_thresh_period  in_accel_z_thresh_thresh_en
>> > in_accel_z_thresh_thresh_value
>> > in_accel_x_thresh_thresh_period  in_accel_y_thresh_thresh_en
>> > in_accel_y_thresh_thresh_value   in_accel_z_thresh_thresh_period
>>
>> Could you paste here the initialization part of iio_chan_spec + iio_event_spec?
>
> How would I do that?

Just look into the code and search for iio_chan_spec and
iio_event_spec declaration.

e.g:

For iio_chan_spec:

static const struct iio_chan_spec iio_dummy_channels[] = {
»       {
»       »       .type = IIO_VOLTAGE,
»       »       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
»       »       .output = 1,
»       »       .indexed = 1,
»       »       .channel = 0,
»       },
};

For iio_event_spec:
static const struct iio_event_spec iio_dummy_event = {
»       .type = IIO_EV_TYPE_THRESH,
»       .dir = IIO_EV_DIR_RISING,
»       .mask_separate = BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),
};
