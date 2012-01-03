Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:45882 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754211Ab2ACRYW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jan 2012 12:24:22 -0500
References: <1325525123-31158-1-git-send-email-jic23@kernel.org> <4F02CDF1.8040504@metafoo.de>
In-Reply-To: <4F02CDF1.8040504@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: Re: [RFC PATCH 0/6] Make iio_info elements attrs and event_attrs struct attribute *
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 03 Jan 2012 17:24:01 +0000
To: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, pirmin.duss@flytec.ch,
	linux-iio@vger.kernel.org, pirmin.duss@flytec.ch
Message-ID: <1e3eebeb-3ed3-40d3-a9b7-4dbcadd6a87c@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Lars-Peter Clausen <lars@metafoo.de> wrote:

>On 01/02/2012 06:25 PM, Jonathan Cameron wrote:
>> This came up whilst I was taking a look at Pirmin Duss' driver the
>other day.
>> When we originally created these the attribute groups were passed
>directly
>> through the core and registered with sysfs.  Since the introduction
>of
>> iio_chan_spec structures this is no longer true.  Their elements are
>simply
>> coppied into attribute_groups created by the core.
>>=20
>> Hence, what other reasons are there for having these as attribute
>groups?
>> The only one I can see is the availablity of the is_visible callback=
=2E
>>=20
>> Now I've always had mixed feelings about that one. It's handy on
>occasion
>> but mostly gets used to handle variations across the different
>devices
>> that are supported by a given driver.  This is true of ad7192,
>ad9834,
>> ad5446 (indirectly).  These can all be easily unwound and handled at
>a
>> higher level (which iio_info varient we use for the device instance)=
=2E
>
>This sounds sensible.
>
>>=20
>> The ad7606 is the only more complex use case here.  There we have
>> attributes whose visibility is dependent on some gpios being
>specified
>> in platform data.  There are two different sets so we have a total o=
f
>4
>> resulting iio_info structures.  Not too bad I suppose.
>
>But this is getting a bit ugly in my opinion. Maybe we can add a attrs
>fields to the iio_dev struct to handle these. This would also allow us
>to
>allocate attributes at runtime if necessary.

You are right. These do seem like they are too dynamic to be in iio _in=
fo.  I will make that change as an additional patch.
>
>>=20
>> A side effect of this is that we can remove the code Lars-Peter just
>added
>> to copy the is_visible callback over. =20
>
>Hm, while I have such a patch locally I don=E2=80=99t think I've send =
it out
>yet.
>
>> That copy is a little odd anyway
>> as it is applied to far more attributes than are initially visible.=20
>whilst
>> all current drivers do a 'is condition true then mask attribute' we
>only
>> need one to do the reverse logic to get nasty to find bug.
>>=20
>> Note this set is on top of Lars-Peters recent rearrangement of the
>event
>> code as obviously the last patch here edits code he moves.
>
>- Lars
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" i=
n
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
