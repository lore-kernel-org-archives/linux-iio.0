Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-229.synserver.de ([212.40.185.229]:1052 "EHLO
	smtp-out-228.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751185Ab2ACJne (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jan 2012 04:43:34 -0500
Message-ID: <4F02CDF1.8040504@metafoo.de>
Date: Tue, 03 Jan 2012 10:44:17 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, pirmin.duss@flytec.ch
Subject: Re: [RFC PATCH 0/6] Make iio_info elements attrs and event_attrs
 struct attribute *
References: <1325525123-31158-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1325525123-31158-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/02/2012 06:25 PM, Jonathan Cameron wrote:
> This came up whilst I was taking a look at Pirmin Duss' driver the ot=
her day.
> When we originally created these the attribute groups were passed dir=
ectly
> through the core and registered with sysfs.  Since the introduction o=
f
> iio_chan_spec structures this is no longer true.  Their elements are =
simply
> coppied into attribute_groups created by the core.
>=20
> Hence, what other reasons are there for having these as attribute gro=
ups?
> The only one I can see is the availablity of the is_visible callback.
>=20
> Now I've always had mixed feelings about that one. It's handy on occa=
sion
> but mostly gets used to handle variations across the different device=
s
> that are supported by a given driver.  This is true of ad7192, ad9834=
,
> ad5446 (indirectly).  These can all be easily unwound and handled at =
a
> higher level (which iio_info varient we use for the device instance).

This sounds sensible.

>=20
> The ad7606 is the only more complex use case here.  There we have
> attributes whose visibility is dependent on some gpios being specifie=
d
> in platform data.  There are two different sets so we have a total of=
 4
> resulting iio_info structures.  Not too bad I suppose.

But this is getting a bit ugly in my opinion. Maybe we can add a attrs
fields to the iio_dev struct to handle these. This would also allow us =
to
allocate attributes at runtime if necessary.

>=20
> A side effect of this is that we can remove the code Lars-Peter just =
added
> to copy the is_visible callback over. =20

Hm, while I have such a patch locally I don=92t think I've send it out =
yet.

> That copy is a little odd anyway
> as it is applied to far more attributes than are initially visible.  =
whilst
> all current drivers do a 'is condition true then mask attribute' we o=
nly
> need one to do the reverse logic to get nasty to find bug.
>=20
> Note this set is on top of Lars-Peters recent rearrangement of the ev=
ent
> code as obviously the last patch here edits code he moves.

- Lars
