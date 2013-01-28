Return-Path: <lars@metafoo.de>
Message-ID: <51068BAE.9090801@metafoo.de>
Date: Mon, 28 Jan 2013 15:31:10 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis Ciocca <denis.ciocca@gmail.com>
CC: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: STMicroelectronics IIO driver
References: <1359157488-15969-1-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1359157488-15969-1-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 01/26/2013 12:44 AM, Denis Ciocca wrote:
> Hi Jonathan, Lars,
> 
> I modified the drivers following the advice of Lars (about code duplication) and Jonathan patches.
> I also used coccicheck to verify the code. I couldn't test the drivers on the physical devices because I was not in office. I hope to do some tests Monday morning. 
> 
> Thanks and Best Regards,
> 
> Denis
>  

Hi,

I think the driver is now in a state where we can merge it, good work.
There are one or two rough edges left, but no blockers and nothing that
can't be fixed in follow up patches. (And to be honest I'm kind of tired of
reviewing the same code over and over again ;))

So for the whole series:

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>


- Lars
