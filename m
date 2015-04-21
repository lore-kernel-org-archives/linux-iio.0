Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57519 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755539AbbDUTfw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Apr 2015 15:35:52 -0400
In-Reply-To: <OF9318C068.0B4E8F22-ONC1257E2D.002AD90B-C1257E2D.002F1441@rohde-schwarz.com>
References: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de> <552ECFF8.2070501@kernel.org> <OF5342D15E.A4BDD05D-ONC1257E29.00294BA0-C1257E29.002B4FCC@rohde-schwarz.com> <5532AFE6.5080407@kernel.org> <OF9318C068.0B4E8F22-ONC1257E2D.002AD90B-C1257E2D.002F1441@rohde-schwarz.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [Patch 0/5] iio: adc: xilinx: Fix some minor issues
From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 21 Apr 2015 20:35:46 +0100
To: Thomas.Betker@rohde-schwarz.com
CC: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	Michal Simek <michal.simek@xilinx.com>,
	=?ISO-8859-1?Q?S=F6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
Message-ID: <12DDD0E6-5B57-48F6-9190-C3E254184426@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 20 April 2015 09:34:10 BST, Thomas.Betker@rohde-schwarz.com wrote:
>Hello Jonathan:
>
>> > With hwmon, we would have inX_input, inX_lowest, inX_highest (in
>fact, 
>we 
>> > had, as Xilinx XADC used to be hwmon -- just to explain where I'm 
>coming 
>> > from). So it made sense to me to use .extended_name = "lowest" to
>have 
>
>> > in_voltageX_lowest_raw/_scale in addition to in_voltageX_raw/_scale
>
>(same 
>> > index X). I understand that I may have read too much into the IIO
>code 
>
>> > here, though, and if there's a better way to do this, I will gladly
>
>use 
>> > it.
>> Hmm, we could as new info_mask elements (like _raw, _scale etc).
>> The nasty corner case is that we might also read them as part of a 
>buffer
>> read.  To do that they will need to be separate 'channels' in their
>own
>> right. 
>> 
>> I'm not entirely sure right now if you can distinguish channels
>purely 
>on
>> the basis of extended name (and different scan index values), but
>that
>> might work, though would be a bit ugly.  There is certainly no 
>fundamental
>> reason you can't do this..
>
>Oh my, it seems I have been a bit unclear here. In my implementation, 
>lowest/highest *are* actually separate channels, with their own _raw
>and 
>_scale. The Xilinx XADC controller has separate registers such as 
>MIN_VCCINT and MAX_VCCINT in addition to VCCINT, and it was fairly 
>straightforward to extend the existing channel set this way.
>
>So lowest/highest is orthogonal to raw/scale (which made it tempting to
>
>use .extend_name). lowest/highest use the same .channel index as the 
>standard channel (so we have a group in_temp0_raw/_scale, 
>in_temp0_lowest_raw/_scale, in_temp0_highest_raw/_scale), but their own
>
>.scan_index (as that has to be unique).
>
>Perhaps we should just use .extend_name = "vccint", "vccint_lowest", 
>"vccint_highest"? (And NULL, "lowest", "highest" for channels which do
>not 
>have a hard-wired purpose.)
Yes. That will do nicely. 
>
>Best regards,
>Thomas Betker

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
