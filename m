Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:32845 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556AbbDTKei (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2015 06:34:38 -0400
Received: by wgin8 with SMTP id n8so173691114wgi.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2015 03:34:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALwa49sxO+iH4qsZEtjF5mhMn2MumLFhyEan1_bG-SUGX9f92w@mail.gmail.com>
References: <CALwa49vRGN_VaJ147PVF8Cf+8vnBotWVh7hmxLj=jaAba5QTTw@mail.gmail.com>
 <5526BD63.3080509@kernel.org> <CALwa49st7A1zSdCmy8Sq8KgAMXiGJySdpoxALTUNEubgvXqyWg@mail.gmail.com>
 <9B863FBE-8332-47EB-8E6C-C8943EF5D185@kernel.org> <CALwa49us7JVeYYga7fJxMx0=EbyLMuaAASGhU8=9AWYV2u96uQ@mail.gmail.com>
 <B74F5E0D-FE1C-422F-9D2E-985137E684E7@jic23.retrosnub.co.uk> <CALwa49sxO+iH4qsZEtjF5mhMn2MumLFhyEan1_bG-SUGX9f92w@mail.gmail.com>
From: "s.rawat" <imsaurabhrawat@gmail.com>
Date: Mon, 20 Apr 2015 16:04:16 +0530
Message-ID: <CALwa49sr6j7igjMSY+Pcn2KzTaVf3qd6JRjPvFjV8DkxS=fMuQ@mail.gmail.com>
Subject: Re: Regarding generic_buffer.c Application for Android
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

After I allow  the device to go into sleep(pressing power button once)
and then run  the generic_buffer app and then make the device wake-up
the app works fine.I don't know if going into the sleep and waking it
up does some sort of reset to the application variables or file
descriptor.

On Mon, Apr 13, 2015 at 3:35 PM, s.rawat <imsaurabhrawat@gmail.com> wrote:
> +closedir(dp)
> +dp = opendir(scan_el_dir);
>
> This seems to work fine.But sometimes polling accel throws error :
> failed to open /dev/iio:device0 .
>
> sorry for reposts : Changed the browser.Was not able to send in "Plain
> text mode"
>
> On Mon, Apr 13, 2015 at 11:56 AM, Jonathan Cameron
> <jic23@jic23.retrosnub.co.uk> wrote:
>>
>>
>> On 13 April 2015 04:40:17 BST, "s.rawat" <imsaurabhrawat@gmail.com> wrote:
>>>On Fri, Apr 10, 2015 at 11:49 AM, Jonathan Cameron <jic23@kernel.org>
>>>wrote:
>>>> Hit google
>>>> http://pubs.opengroup.org/onlinepubs/009695399/functions/seekdir.html
>>>> So for POSIX compliance they are optional.
>>>
>>>You mean seekdir(dp, 0); in function inline int
>>>build_channel_array(...) is optional?If I comment it, will it have no
>>>effect? This function is called inside main() of generic_buffer.c and
>>>I cant get it compiled with the tool chain I have.Is there any
>>>alternate code I can replace it with if it is Not Optional?
>> The functionality is not optional. There is no obligation for the operating system to implement seekdir.
>>
>> Here equivalent is probably to close and reopen the directory.
>>>
>>>I can take care of le16toh/be16toh.
>>>
>>>Thanks and Rgds,
>>>S
>>
>> --
>> Sent from my Android device with K-9 Mail. Please excuse my brevity.
