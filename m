Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58179 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbbDJGT6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Apr 2015 02:19:58 -0400
In-Reply-To: <CALwa49st7A1zSdCmy8Sq8KgAMXiGJySdpoxALTUNEubgvXqyWg@mail.gmail.com>
References: <CALwa49vRGN_VaJ147PVF8Cf+8vnBotWVh7hmxLj=jaAba5QTTw@mail.gmail.com> <5526BD63.3080509@kernel.org> <CALwa49st7A1zSdCmy8Sq8KgAMXiGJySdpoxALTUNEubgvXqyWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: Regarding generic_buffer.c Application for Android
From: Jonathan Cameron <jic23@kernel.org>
Date: Fri, 10 Apr 2015 07:19:53 +0100
To: "s.rawat" <imsaurabhrawat@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <9B863FBE-8332-47EB-8E6C-C8943EF5D185@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 10 April 2015 05:18:56 BST, "s.rawat" <imsaurabhrawat@gmail.com> wrote:
>On Thu, Apr 9, 2015 at 11:26 PM, Jonathan Cameron <jic23@kernel.org>
>wrote:
>> Not as such. However it is certainly curious that you have them
>missing.
>> These provide direct sysfs access to the accelerations.
>>
>> We did at one point make it a requirement for the iio_chan_spec to
>explicitly include the IIO_CHAN_INFO_RAW bit
>> rather than using the prior separate callbacks for that.  Perhaps it
>is missing in your driver?
>>
>> What is the actual driver in question?
>The acutal driver is accel,gyro and magn.OK,i agree this is not a
>mandatory requirement for the generic_buffer app to work.
>The illegal termination of the application is due to the changes I
>have done in the build_channel_array for function  seekdir(dp, 0).I
>found that I can compile/test the app safely using arm tool chain or
>gcc but when I am trying to compile the application using ndk(native
>android tool chain ) I get errors for undefined references for these
>functions below :
>seekdir()
Hit google
http://pubs.opengroup.org/onlinepubs/009695399/functions/seekdir.html
So for POSIX compliance they are optional.
>be16toh()
https://code.google.com/p/android/issues/detail?id=41769 suggest at least older android uses betoh16.

>le16toh()
>Are these functions portable?
>and on cross-compiling with x86 tool chain for x86 32 bit platform I
>get errors for missing headers unistd.h ,dirent.h,etc. I guess
>unistd.h are the part of libc which may not be present in the tool
>chain I am using.Is that the reason?
Possibly...

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
