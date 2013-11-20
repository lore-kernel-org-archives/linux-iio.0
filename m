Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:62514 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab3KTKZh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 Nov 2013 05:25:37 -0500
Received: by mail-we0-f171.google.com with SMTP id q58so3238952wes.30
        for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2013 02:25:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAP9ODKoX_ozDo0CGMSQZPMBFhOEZfrYnm2esySViMCFtGE1Q1w@mail.gmail.com>
References: <1378130401-22367-1-git-send-email-angelo.compagnucci@gmail.com> <CAP9ODKoX_ozDo0CGMSQZPMBFhOEZfrYnm2esySViMCFtGE1Q1w@mail.gmail.com>
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Date: Wed, 20 Nov 2013 11:24:55 +0100
Message-ID: <CA+TH9VmSLtzYE=BVt+EnPxY=T35VEQ5A_69tzbkg1SWfLr2Q2A@mail.gmail.com>
Subject: Re: [PATCH v10] Add Microchip MCP3422/3/4 high resolution ADC
To: Otavio Salvador <otavio@ossystems.com.br>
Cc: linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Otavio,

MCP3426/7/8 Are different beast, not so much different from
mcp3422/3/4. Actually I'm building a board to test out the code I'm
writing for MCP3426/7/8, and it should be ready in a few days.

After finalizing the code and the necessary QA, I will publish it on this ML.

Sincerly Angelo.


2013/11/20 Otavio Salvador <otavio@ossystems.com.br>:
> On Mon, Sep 2, 2013 at 11:00 AM, Angelo Compagnucci
> <angelo.compagnucci@gmail.com> wrote:
>> Kawabonga! It works! Really, but really (no joke here!) thank you
>> for your precious support and sorry for not being so smart to
>> understand what you were saying me. Sorry again for being so pedantic!
>>
>> I'm planning to write a tutorial based on my journey, something like
>> "Howto write your first IIO LDD", what do you think?
>>
>> Attached here, there is the latest version of the patch based on jour suggestions.
>> I think all of your concerns are solved now.
>>
>> Thank you again!
>>
>> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> ...
>> +static const struct i2c_device_id mcp3422_id[] = {
>> +       { "mcp3422", 2 },
>> +       { "mcp3423", 3 },
>> +       { "mcp3424", 4 },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, mcp3422_id);
>> +
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id mcp3422_of_match[] = {
>> +       { .compatible = "mcp3422" },
>> +       { }
>
> Shouldn't this be mcp,mcp3422?
>
> Another question, are you aware of need changes to use with mcp3428?
> Otherwise I will look at this.
>
> --
> Otavio Salvador                             O.S. Systems
> http://www.ossystems.com.br        http://code.ossystems.com.br
> Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750



-- 
Profile: http://it.linkedin.com/in/compagnucciangelo
