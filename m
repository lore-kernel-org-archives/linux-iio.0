Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <1473832511-sup-5279@pruts.nl>
References: <20160910191946.30105-1-ico@pruts.nl> <99ce25ac-2330-ad53-151d-f580226906eb@kernel.org> <1473832511-sup-5279@pruts.nl>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] iio: accel: sca3000_core: implemented IIO_CHAN_INFO_SAMP_FREQ
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Wed, 14 Sep 2016 07:26:37 +0100
To: Ico Doornekamp <ico@pruts.nl>,Jonathan Cameron <jic23@kernel.org>
CC: linux-iio <linux-iio@vger.kernel.org>
Message-ID: <AD989092-B155-46DA-AC09-5D251823EB9C@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 14 September 2016 06:59:23 BST, Ico Doornekamp <ico@pruts.nl> wrote:
>* On 2016-09-13 19:35:28 +0200, Jonathan Cameron wrote:
> 
>> Other than one big issue, the patch looks very good.
>> 
>> You actually need to add this entry to one of the info_mask bitmaps
>to
>> have the attributes instantiated.
>
>I suspected as much, but I wasn't quite sure about the semantics of the
>fields, and when to use info_mask_shared_by_type vs
>info_mask_shared_by_all.
Here we have existing correct ABI to userspace so we should stick to what is
present. Shared by all will keep naming as simply sampling_frequency.

J

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
