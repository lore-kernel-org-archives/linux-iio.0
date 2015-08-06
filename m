Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:45413 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755500AbbHFKmD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 6 Aug 2015 06:42:03 -0400
Date: Thu, 6 Aug 2015 12:42:02 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Crt Mori <cmo@melexis.com>
cc: linux-iio@vger.kernel.org
Subject: Re: Spliting u16, u32 to u8 array
In-Reply-To: <CAKv63uuEs4qVzKyAfRRX6ruxYD65L_UaYTTHnZpfc_rRvaX=tg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1508061229430.24774@pmeerw.net>
References: <CAKv63uuEs4qVzKyAfRRX6ruxYD65L_UaYTTHnZpfc_rRvaX=tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

> I am sure at least some of you were faced to split a u16 or u32 value
> in u8 array without being affected by host endianness. My search
> turned empty for a standardized function for this task, but this seems
> quite improbable. My task is to send 16 bit LE data through i2c.
> 
> I am looking for something like:
> static void u16_to_u8_array(u16 value, u8 *array)
> {
>         *array = cpu_to_le16(value) >> 8;
>         *(++array) = (u8) cpu_to_le16(value);
> }

how about

static void u16_to_le16_array(u16 value, __le16 *array)
{
	*array++ = cpu_to_le16(value);
}

and calling it with a cast if need be, such as

char *u8array;
u16_to_le16_array(123, (__le16 *) u8array)

an issue could be alignment of the u8array

I'd try to avoid u8 altogether and work with le16 as a datatype

p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
