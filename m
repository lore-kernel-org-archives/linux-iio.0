Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:55421 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932516Ab3B0Stb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 13:49:31 -0500
Message-ID: <512E55AA.6050203@metafoo.de>
Date: Wed, 27 Feb 2013 19:51:22 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Chris Micali <chrismicali@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: IIO Drivers
References: <26387F1A648A4D3D9BB4142C4F0AAE98@gmail.com> <512E2F31.8000604@metafoo.de> <B42F83EDFE8B4D2D8D46B6241B49B4E8@gmail.com> <512E3592.4020702@metafoo.de> <4AEA8015FE824807B3CF62B7B35FC5D3@gmail.com> <512E43A9.4090301@metafoo.de> <5277B88AB1FF4E6A83920766C0BE13F7@gmail.com> <512E5054.8030905@kernel.org>
In-Reply-To: <512E5054.8030905@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/27/2013 07:28 PM, Jonathan Cameron wrote:
> On 02/27/2013 05:36 PM, Chris Micali wrote:
>> lars, 
>>
>> I was under the impression that flag gets added automatically by iio_triggered_buffer_setup (industrialiio-triggers.c:77) - I actually am now able to enable the scan_element after changing my channel .channel and .scan_index to 0 (trying to match exactly the other drivers.)
> 

Yea, you are right I missed the iio_triggered_buffer_setup part.

> Strange, scan_index should have defaulted to zero and the .channel value shouldn't have mattered
> for buffered reads (just effects naming).  Might have caused issues with userspace expecting a channel 0
> though...

I guess the scan_index had nothing to do with this, but I suggested to set
scan_elements/in_voltage0_en to 1, so this clearly wouldn't have worked with
.channel being 1.

> 
>>  When i run general_buffer (from the docs dir) with that scan element enabled it can no longer read the trigger (Could not open /trigger/current_trigger  Failed to write current_trigger file) - this succeeds if that scan_element is not enabled.  

You can't change the trigger if the buffer is currently enabled. Make sure that
he buffer is disabled (check the buffer/enable attribute).

- Lars
u
