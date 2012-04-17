Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:40644 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab2DQGOQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 17 Apr 2012 02:14:16 -0400
References: <1333971244-10684-1-git-send-email-srinidhi.kasagar@stericsson.com> <4F834BE1.2010107@kernel.org> <20120417060123.GA923@bnru02>
In-Reply-To: <20120417060123.GA923@bnru02>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] staging: iio: add lsm303dlh magnetometer driver
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 17 Apr 2012 07:14:04 +0100
To: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>
Message-ID: <0ea7ad70-6bc0-425c-9666-28f9032efd11@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> wrote:

>On Mon, Apr 09, 2012 at 22:51:45 +0200, Jonathan Cameron wrote:
>> On 04/09/2012 12:34 PM, Srinidhi KASAGAR wrote:
>> > Add support for lsm303dlh magnetometer device.
>> >
>> > Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
>> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> Hi Srinidhi,
>> 
>> Basically a sound driver with a few easy bits to fix.
>> 
>> Few nitpicks and the error paths in probe need another look.
>> 
>Hi Jonathan,
>
>[...]
>
>> 
>> We have the old question of _range attributes as well and their
>> interaction with scale.  I've always been dubious about these,
>> mainly because it's not entirely obvious how to format the
>> weirder general cases.  Do you have a pressing need for range
>> or could it just be dropped in favour of allowing write for the
>> scale parameter? If nothing else, scale is available for inkernel
>> users and range isn't.
>If I need to drop range in favor of allowing write access for scale
>as you mentioned above, do you mean to implement _write_raw with
>IIO_CHAN_INFO_CALIBSCALE abi? Does it mean that user should be able
>to pass the scale factors so that driver interprets it to the
>corresponding range? 
>
>Srinidhi
Yes.   Scale should allow userspace to convert to the SI unit as well for any raw channels.  Range only does that if we also know the values the raw adc count can take.  
-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
