Return-Path: <imsaurabhrawat@gmail.com>
MIME-Version: 1.0
In-Reply-To: <9B863FBE-8332-47EB-8E6C-C8943EF5D185@kernel.org>
References: <CALwa49vRGN_VaJ147PVF8Cf+8vnBotWVh7hmxLj=jaAba5QTTw@mail.gmail.com>
 <5526BD63.3080509@kernel.org> <CALwa49st7A1zSdCmy8Sq8KgAMXiGJySdpoxALTUNEubgvXqyWg@mail.gmail.com>
 <9B863FBE-8332-47EB-8E6C-C8943EF5D185@kernel.org>
From: "s.rawat" <imsaurabhrawat@gmail.com>
Date: Mon, 13 Apr 2015 09:10:17 +0530
Message-ID: <CALwa49us7JVeYYga7fJxMx0=EbyLMuaAASGhU8=9AWYV2u96uQ@mail.gmail.com>
Subject: Re: Regarding generic_buffer.c Application for Android
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Apr 10, 2015 at 11:49 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> Hit google
> http://pubs.opengroup.org/onlinepubs/009695399/functions/seekdir.html
> So for POSIX compliance they are optional.

You mean seekdir(dp, 0); in function inline int
build_channel_array(...) is optional?If I comment it, will it have no
effect? This function is called inside main() of generic_buffer.c and
I cant get it compiled with the tool chain I have.Is there any
alternate code I can replace it with if it is Not Optional?

I can take care of le16toh/be16toh.

Thanks and Rgds,
S
