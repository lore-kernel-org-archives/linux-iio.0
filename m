Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43643 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbaCYGvB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 25 Mar 2014 02:51:01 -0400
In-Reply-To: <20140324230607.GA2035@taihen.jp>
References: <1395356482-7446-1-git-send-email-malattia@linux.it> <1395356482-7446-11-git-send-email-malattia@linux.it> <532F36D2.4020701@kernel.org> <20140324230607.GA2035@taihen.jp>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 10/11] sony-laptop: als support
From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 25 Mar 2014 06:50:51 +0000
To: Mattia Dongili <malattia@linux.it>
CC: Matthew Garrett <mjg59@srcf.ucam.org>,
	platform-driver-x86@vger.kernel.org,
	Javier Achirica <jachirica@gmail.com>,
	linux-iio@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>,
	Marco Chiappero <marco@absence.it>
Message-ID: <d9aa97dc-cfdb-4394-b71d-ea1ed281ba00@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On March 24, 2014 11:06:07 PM GMT+00:00, Mattia Dongili <malattia@linux.it> wrote:
>On Sun, Mar 23, 2014 at 07:32:34PM +0000, Jonathan Cameron wrote:
>> On 20/03/14 23:01, Mattia Dongili wrote:
>> >From: Javier Achirica <jachirica@gmail.com>
>> >
>> >vaios come with two different type of ACPI based ALS controls. The
>...
>
>Hi Jonathan,
>thanks for the extensive review.
>I can answer some of your questions, those related to the taos driver
>in
>particular need to wait for Javier as large part of the work was plain
>reverse engineering the windows code that he did.
>
>> I hate to say it but my first reaction to this was, 'What are so
>> many functions doing in one file in the first place?'
>> 
>> The embedded world has been busy splitting up and reparcelling large
>> files like this so the various devices end up within the correct
>> subsystems. I won't even go into all the reasons for this as they
>> are listed everywhere else?  Is this just a case of modifying old
>> code no one wants to touch on a larger scale or is there actually
>> resistance to breaking new functionality out of this file and
>> into nice clean small chunks?
>
>I don't think there is any resistance per-se and to some extent it has
>been done in the past (see meye.ko).
>On the other hand there is no documentation on the devices this driver
>is about and any abstraction you put in place to generalize access and
>to allow splitting functionalities, will break. I have to admit that
>things have somehow settled recently (and the Vaio brand has just been
>buried, we'll see what happens) so making an attempt may make sense
>now.
>But then again, I'm not sure that making a mini-subsystem out of an
>undocumented device/interface is going to pay out.
>
>> So my first request is can we at least split this new functionality
>> out?
>
>we can certainly try. :)
>Though some functionalities are so interdependent from each other that
>I'm not sure it makes much sense (backlight Fn-keys, panel backlight
>and
>als are the worst).
>
>> As I look through what we have here, it looks like we ought to have
>> this functionality alone split into the ALS sensor and a backlight
>> driver (which can by all means use the standard interfaces to
>> talk to the ALS)... (event support for in kernel users isn't there
>> yet, but this might motivate us to hurry up with it).
>> 
>> The bulk of this driver is actually just a set of nasty access
>routines
>> and then functionality that already exists in the existing tsl2563
>driver.
>> Hence, unless there are very good reasons why not I would suggest the
>> following.
>> 
>> 1) Convert the existing tsl2563 driver over to using regmap.
>> 2) Add regmap support for the access routines we have here then add
>the
>>    little bit of code needed to make the tsl2563 register
>appopriately.  This
>>    may require a small amount of magic mfd like code in here.
>> (plan b on this is to perhaps create an i2c bus driver using the sony
>> specific calls).
>
>I need to figure out what regmaps are about (a quick look in
>include/linux/regmap.h reveals a lot), this is going to be a piece of
>work.
>
>> 3) Figure out what extra bits are that are needed by the ALS driver
>we have
>>    here and add them on (kelvin support and perhaps a few other
>bits).
>> 4) Then and only then take on any non ALS elements in here (such as
>the
>>    back light).
>
>most of the backlight code here is really a workaround to a sick
>behaviour that vaios have once you enable the als device. It's
>generally
>unrelated to the als portion of the driver except that once you
>introduce the latter, the former will break. The code is folded
>together
>to avoid being broken at any stage but it can be split to different
>changes if it makes more sense.
>
>> The other als driver (one where all the clever stuff is hidden)
>should ideally
>> be a completely separate als driver (be it a very simple one.
>> 
>> Anyhow, your code is reasonably clean but I think some of these
>questions about
>> the fundamental approach need addressing to avoid getting ourselves
>into a
>> nasty mess in the long term.   Sorry if this review seems a little
>negative.
>
>it does indeed but I wasn't expecting this enourmous blob to go through
>unnoticed and this is the type of feedback I wanted to get this code
>unstuck and finally ready for inclusion.
>
>I'll go through your comments in a few iterations to clean up the
>obvious first and evaluate the larger rework (i.e. merging with the
>current taos driver and splitting the als portion of sony-laptop) with
>more stable code at hand.
>
>Most of the questions you have about the driver itself will need to be
>answered by Javier though, I have only a few comments below about
>generic code in sony-laptop.c.
>
>> I appreciate that you've only taken the approach taken throughout
>this file!
>> 
>> Just as an aside, is there any interest in cleaning this whole file
>up?
>> The sonypi device looks like it should registering a whole host of
>standard
>> interfaces...
>
>iirc, sonypi doesn't have enough known functionality to cover the
>standard interfaces, it largely predates most of them. It's quite
>some time I don't look into it and it's actually a legacy device that
>is likely better be deprecated than worked on. If anybody wants to take
>it on, I'm not opposed though.
>
>> Jonathan
>> >Cc: Jonathan Cameron <jic23@kernel.org>
>> >Cc: linux-iio@vger.kernel.org
>> >Cc: Jingoo Han <jg1.han@samsung.com>
>> >Cc: Marco Chiappero <marco@absence.it>
>> >Signed-off-by: Javier Achirica <jachirica@gmail.com>
>> >Signed-off-by: Mattia Dongili <malattia@linux.it>
>> >---
>> >  Documentation/laptops/sony-laptop.txt |   31 +
>> >  drivers/platform/x86/Kconfig          |    1 +
>> >  drivers/platform/x86/sony-laptop.c    | 1111
>++++++++++++++++++++++++++++++++-
>> >  3 files changed, 1128 insertions(+), 15 deletions(-)
>> >
>> >diff --git a/Documentation/laptops/sony-laptop.txt
>b/Documentation/laptops/sony-laptop.txt
>...
>> >diff --git a/drivers/platform/x86/Kconfig
>b/drivers/platform/x86/Kconfig
>...
>> >diff --git a/drivers/platform/x86/sony-laptop.c
>b/drivers/platform/x86/sony-laptop.c
>...
>
>[large chop, I'll let Javier comment on those questions]
>
>> >@@ -1065,20 +1206,43 @@ static int sony_nc_get_brightness_ng(struct
>backlight_device *bd)
>> >  	return (result & 0xff) - sdev->offset;
>> >  }
>> >
>> >-static int sony_nc_update_status_ng(struct backlight_device *bd)
>> >+static int __sony_nc_set_brightness_ng(struct sony_backlight_props
>*bl,
>> >+		int brightness)
>> >  {
>> >-	int value, result;
>> >-	struct sony_backlight_props *sdev =
>> >-		(struct sony_backlight_props *)bl_get_data(bd);
>> >+	int result = 0;
>> >+	int value = brightness + bl->offset;
>> >
>> >-	value = bd->props.brightness + sdev->offset;
>> >-	if (sony_call_snc_handle(sdev->handle, sdev->cmd_base | (value <<
>0x10),
>> >+	if (sony_call_snc_handle(bl->handle, bl->cmd_base | (value <<
>0x10),
>> >  				&result))
>> >  		return -EIO;
>> >
>> >  	return value;
>> >  }
>> Whilst this stuff is presumably being driver from the ALS it is
>decidedly
>> back light specific. Perhaps I'm idealistic in thinking it should be
>> a different driver.
>
>err, this hunk should not have made it here at all. Part of the other
>backlight work is in this patch for the reason I explained above but
>this one is really extraneous.
>
>> >
>> >+
>> >+static int sony_nc_update_status_ng(struct backlight_device *bd)
>> >+{
>> >+	struct sony_backlight_props *sdev =
>> >+		(struct sony_backlight_props *)bl_get_data(bd);
>> >+
>> >+	return __sony_nc_set_brightness_ng(sdev, bd->props.brightness);
>> >+}
>> >+
>> >+static void sony_nc_brightness_changed_ng(struct backlight_device
>*bd,
>> >+		int brightness, int max_brightness)
>> >+{
>> >+	int new_brightness =
>> >+		brightness * bd->props.max_brightness / max_brightness;
>> >+	struct sony_backlight_props *sdev =
>> >+		(struct sony_backlight_props *)bl_get_data(bd);
>> >+
>> >+	dprintk("brightness changed cur: %d, max: %d -> new: %d\n",
>brightness,
>> >+			max_brightness, new_brightness);
>> >+
>> >+	__sony_nc_set_brightness_ng(sdev, new_brightness);
>> >+	backlight_force_update(bd, BACKLIGHT_UPDATE_HOTKEY);
>> >+}
>> >+
>> >  static const struct backlight_ops sony_backlight_ops = {
>> >  	.options = BL_CORE_SUSPENDRESUME,
>> >  	.update_status = sony_backlight_update_status,
>> >@@ -1088,6 +1252,7 @@ static const struct backlight_ops
>sony_backlight_ng_ops = {
>> >  	.options = BL_CORE_SUSPENDRESUME,
>> >  	.update_status = sony_nc_update_status_ng,
>> >  	.get_brightness = sony_nc_get_brightness_ng,
>> >+	.brightness_changed = &sony_nc_brightness_changed_ng,
>> >  };
>> >
>> >  /*
>> >@@ -1201,7 +1366,8 @@ static int sony_nc_hotkeys_decode(u32 event,
>unsigned int handle)
>> >  enum event_types {
>> >  	HOTKEY = 1,
>> >  	KILLSWITCH,
>> >-	GFX_SWITCH
>> >+	GFX_SWITCH,
>> >+	ALS
>> >  };
>> Hmm. I don't suppose suggesting this should be an mfd with a nice
>clean
>> event hook up interface will go down to well?
>
>ah, a multi function device. Again I'd need to look how it would look
>like adding that to sony-laptop but these are essentially for
>triggering
>acpi events.
>Would it make it that much more clean than decoding the event from the
>GPE notification callback and sending it via ACPI's netlink interface
>(which is all we are doing here)?
>
>> >  static void sony_nc_notify(struct acpi_device *device, u32 event)
>> >  {
>> >@@ -1276,6 +1442,38 @@ static void sony_nc_notify(struct acpi_device
>*device, u32 event)
>> >  			ev_type = GFX_SWITCH;
>> >  			real_ev = __sony_nc_gfx_switch_status_get();
>> >  			break;
>> >+
>> >+		case 0x0143:
>> >+		case 0x014b:
>> >+		case 0x014c:
>> >+		case 0x0163:
>> Could you document what these different events are here?  Would make
>> it easier to review.
>
>yes, I can add documentation but this is not als specific.
>In general SNC exposes a number of "handles" (those you see above) in
>an
>indexed table (see find_snc_handle). All event notifications and calls
>into the device methods (SN06 and SN07 are the entry points) specify
>the
>offset at which the desired handle is.
>Each handle cover one or more functionality based on the arguments
>provided.
>Different handle may cover similar functionalities and are different
>from model to model. 
>
>The functionalities are easier to see in sony_nc_function_setup where
>each handle has it's corresponding setup function called.
>
>The event decoding here (sony_nc_notify) have to look at what handle is
>associated to it and decide accordingly (map a hotkey, read a switch
>position, read additional "light" event information).
>
>...
>
>> You are pushing events without any direct control interface for
>them...
>> >+	iio_push_event(als_handle->indio_dev,
>> >+		       IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
>> >+					    0,
>> >+					    IIO_EV_TYPE_THRESH,
>> >+					    IIO_EV_DIR_EITHER),
>> >+		       iio_get_time_ns());
>...
>> Again, you are pushing without there being any sysfs elements to
>control them..
>> With those missing there is no way for userspace to know that the
>device
>> might spit out events, or what they might be...
>> 
>> >+	iio_push_event(als_handle->indio_dev,
>> >+		       IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
>> >+					    0,
>> >+					    IIO_EV_TYPE_THRESH,
>> >+					    IIO_EV_DIR_EITHER),
>> >+		       iio_get_time_ns());
>...
>> >+static const struct iio_event_spec sony_events[] = {
>> >+	{
>> >+		.type = IIO_EV_TYPE_THRESH,
>> >+		.dir = IIO_EV_DIR_EITHER
>> Would expect some control stuff in here as well...
>> >+	}
>
>what do you mean? do you have an example I can look at?
As it is somewhat relevant how about the tsl2563 driver...

https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/tree/drivers/iio/light/tsl2563.c?h=togreg&id=239670ef48dfff9cf07675acdb3bb7deee4853e1

See the mask separate elements and event related callbacks.
>
>Thanks

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
