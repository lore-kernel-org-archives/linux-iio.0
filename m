Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49894 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbbDMG1V (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2015 02:27:21 -0400
In-Reply-To: <CALwa49us7JVeYYga7fJxMx0=EbyLMuaAASGhU8=9AWYV2u96uQ@mail.gmail.com>
References: <CALwa49vRGN_VaJ147PVF8Cf+8vnBotWVh7hmxLj=jaAba5QTTw@mail.gmail.com> <5526BD63.3080509@kernel.org> <CALwa49st7A1zSdCmy8Sq8KgAMXiGJySdpoxALTUNEubgvXqyWg@mail.gmail.com> <9B863FBE-8332-47EB-8E6C-C8943EF5D185@kernel.org> <CALwa49us7JVeYYga7fJxMx0=EbyLMuaAASGhU8=9AWYV2u96uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: Regarding generic_buffer.c Application for Android
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Mon, 13 Apr 2015 07:26:52 +0100
To: "s.rawat" <imsaurabhrawat@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <B74F5E0D-FE1C-422F-9D2E-985137E684E7@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 13 April 2015 04:40:17 BST, "s.rawat" <imsaurabhrawat@gmail.com> wrote:
>On Fri, Apr 10, 2015 at 11:49 AM, Jonathan Cameron <jic23@kernel.org>
>wrote:
>> Hit google
>> http://pubs.opengroup.org/onlinepubs/009695399/functions/seekdir.html
>> So for POSIX compliance they are optional.
>
>You mean seekdir(dp, 0); in function inline int
>build_channel_array(...) is optional?If I comment it, will it have no
>effect? This function is called inside main() of generic_buffer.c and
>I cant get it compiled with the tool chain I have.Is there any
>alternate code I can replace it with if it is Not Optional?
The functionality is not optional. There is no obligation for the operating system to implement seekdir.

Here equivalent is probably to close and reopen the directory.
>
>I can take care of le16toh/be16toh.
>
>Thanks and Rgds,
>S

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
