Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61892 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933Ab2LBLUJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Dec 2012 06:20:09 -0500
MIME-Version: 1.0
In-Reply-To: <CAObPJ3NM7mn+pXJ801hC2Dn7t9kqp4X_FuD8TSmJ6-eH7UP8pA@mail.gmail.com>
References: <CAHR064j_7Y3wYXVXmC4TqZHxkqa0Z2HK84-OaDTiC7oesB_TrQ@mail.gmail.com>
	<1354157205-2956-1-git-send-email-marxin.liska@gmail.com>
	<1354157205-2956-2-git-send-email-marxin.liska@gmail.com>
	<CAHR064gj3CUUZyuGiw6WhLjGQrhq-eAOKr-=+UmpW2Ry3mce8g@mail.gmail.com>
	<CAObPJ3NM7mn+pXJ801hC2Dn7t9kqp4X_FuD8TSmJ6-eH7UP8pA@mail.gmail.com>
Date: Sun, 2 Dec 2012 11:20:07 +0000
Message-ID: <CAHR064g+tdWHM21B3rG-XpOpgmd5nMXrXe86UjzaozaNpoL2Vw@mail.gmail.com>
Subject: Re: [PATCH] ACPI ALS driver for iio introduced.
From: Corentin Chary <corentin.chary@gmail.com>
To: =?UTF-8?Q?Martin_Li=C5=A1ka?= <marxin.liska@gmail.com>
Cc: =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	"platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, linux-iio@vger.kernel.org,
	"Zhang, Rui" <rui.zhang@intel.com>, joeyli <jlee@suse.com>,
	Len Brown <len.brown@intel.com>, pavel@denx.de,
	Jon Brenner <jbrenner@taosinc.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

>
> Yeah, it's really strange. Following piece of code is called in
> non-atomic.h:
>
> static inline int test_bit(int nr, const volatile unsigned long *addr)
> {
> return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
> }
>
> Where nr == 0 and *addr == 1, giving me really -1 return value. If I am
> right it's something like: 1 >> 0 ?
>
> You are right, "adjustment" should be major observed variable. I could
> create a channel where adjustment will be visible according to given mapping
> table. Do you have any idea how to expose mentioned mapping table? Both will
> be added in further patch.

I don't see how test_bit(0, (long[]){1}) could return -1.
Are you sure of these values ? Could you add some printk before and
after the test, and show us the trace ?


--
Corentin Chary
http://xf.iksaif.net
