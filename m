Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51358 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755147AbcKERtk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Nov 2016 13:49:40 -0400
Subject: Re: [PATCH] iio: orientation: hid-sensor-rotation: Add PM function
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Song, Hongyan" <hongyan.song@intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <1477357563-16794-1-git-send-email-hongyan.song@intel.com>
 <5c8d5490-93c9-a8c8-2d25-dbec3e2dc86f@kernel.org>
 <1477873760.8025.46.camel@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <74221bb4-b854-4e64-a645-e4271d188178@kernel.org>
Date: Sat, 5 Nov 2016 17:49:35 +0000
MIME-Version: 1.0
In-Reply-To: <1477873760.8025.46.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/10/16 00:32, Pandruvada, Srinivas wrote:
> On Sun, 2016-10-30 at 16:22 +0000, Jonathan Cameron wrote:
>> On 25/10/16 02:06, Song Hongyan wrote:
>>>
>>> Rotation sensor function does not work due to miss PM function.
>>> Add common hid sensor iio pm function for rotation sensor.
>>>
>>> Signed-off-by: Song Hongyan <hongyan.song@intel.com>
> 
> Fixes: 2b89635e9a9e ("iio: hid_sensor_hub: Common PM functions")
> 
>> Does this completely prevent the driver working or merely make it
>> consume
>> too much power?
> If CONFIG_PM is not defined, then this prevents this sensor to
> function. So above commit caused this.
> 
> This sensor was supposed to be always on to trigger wake up in prior
> external hubs. But with the new ISH hub this is not the case.
>>
>> Only really makes a difference to which route it takes to mainline
>> and how
>> fast it gets there!
> If possible push to 4.9 and mark to stable.
I've added some more description cribbed from your reply here
and a little header from me to make the point it's actually a fix
that wants to go in fast!

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> 
> Thanks,
> Srinivas
> N�����r��y���b�X��ǧv�^�)޺{.n�+����{��*"��^n�r���z���h����&���G���h�(�階�ݢj"���m�����z�ޖ���f���h���~�mml==
> 

