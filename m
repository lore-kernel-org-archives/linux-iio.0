Return-Path: <pmeerw@pmeerw.net>
Date: Fri, 8 Jun 2012 09:12:10 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org, jic23@cam.ac.uk
Subject: Re: [PATCH] iio: add mcp4725 I2C DAC driver
In-Reply-To: <4FD0D1CB.4000004@kernel.org>
Message-ID: <alpine.DEB.2.01.1206080909380.26184@pmeerw.net>
References: <1339057809-17345-1-git-send-email-pmeerw@pmeerw.net> <4FD0D1CB.4000004@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello Jonathan,

> from reading the code. Anyhow few things came up via sparse and and
> my arm toolchain... (not sure which version off the top of my head)..

>   CHECK   drivers/iio/dac/mcp4725.c
> drivers/iio/dac/mcp4725.c:45:53: warning: incorrect type in argument 2
> (different base types)
> drivers/iio/dac/mcp4725.c:45:53:    expected char const *buf
> drivers/iio/dac/mcp4725.c:45:53:    got unsigned char [usertype] (
> *<noident> )[2]
> drivers/iio/dac/mcp4725.c:58:53: warning: incorrect type in argument 2
> (different base types)
> drivers/iio/dac/mcp4725.c:58:53:    expected char const *buf
> drivers/iio/dac/mcp4725.c:58:53:    got unsigned char [usertype] (
> *<noident> )[2]
>   CC [M]  drivers/iio/dac/mcp4725.o

I did not know about sparse

compiling out-of-tree with my toolchain did not yield above warnings, 
sorry for the extra review cycle

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
