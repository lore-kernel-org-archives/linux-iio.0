Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:57606 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab3KTCYl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Nov 2013 21:24:41 -0500
Received: by mail-ob0-f182.google.com with SMTP id wo20so4914136obc.41
        for <linux-iio@vger.kernel.org>; Tue, 19 Nov 2013 18:24:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1378130401-22367-1-git-send-email-angelo.compagnucci@gmail.com>
References: <1378130401-22367-1-git-send-email-angelo.compagnucci@gmail.com>
Date: Wed, 20 Nov 2013 00:24:41 -0200
Message-ID: <CAP9ODKoX_ozDo0CGMSQZPMBFhOEZfrYnm2esySViMCFtGE1Q1w@mail.gmail.com>
Subject: Re: [PATCH v10] Add Microchip MCP3422/3/4 high resolution ADC
From: Otavio Salvador <otavio@ossystems.com.br>
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Sep 2, 2013 at 11:00 AM, Angelo Compagnucci
<angelo.compagnucci@gmail.com> wrote:
> Kawabonga! It works! Really, but really (no joke here!) thank you
> for your precious support and sorry for not being so smart to
> understand what you were saying me. Sorry again for being so pedantic!
>
> I'm planning to write a tutorial based on my journey, something like
> "Howto write your first IIO LDD", what do you think?
>
> Attached here, there is the latest version of the patch based on jour suggestions.
> I think all of your concerns are solved now.
>
> Thank you again!
>
> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
...
> +static const struct i2c_device_id mcp3422_id[] = {
> +       { "mcp3422", 2 },
> +       { "mcp3423", 3 },
> +       { "mcp3424", 4 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, mcp3422_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id mcp3422_of_match[] = {
> +       { .compatible = "mcp3422" },
> +       { }

Shouldn't this be mcp,mcp3422?

Another question, are you aware of need changes to use with mcp3428?
Otherwise I will look at this.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
