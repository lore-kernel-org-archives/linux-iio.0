Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932127AbdJZQmF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Oct 2017 12:42:05 -0400
Date: Thu, 26 Oct 2017 17:42:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tiberiu Breana <tiberiu.a.breana@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] iio/accel/stk8ba50: Use common error handling code
 in stk8ba50_probe()
Message-ID: <20171026174200.5c00b06d@archlinux>
In-Reply-To: <0f26a13b-7bbf-525b-a864-8aa8e13c3aef@users.sourceforge.net>
References: <5ab7e200-2dea-63e2-06db-0e185f563d16@users.sourceforge.net>
        <0f26a13b-7bbf-525b-a864-8aa8e13c3aef@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 25 Oct 2017 22:16:31 +0200
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 25 Oct 2017 21:36:03 +0200
> 
> * Add a jump target so that a specific error message is stored only once
>   at the end of this function implementation.
> 
> * Replace two calls of the function "dev_err" by goto statements.
> 
> * Adjust condition checks.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Again readability is hurt by the more complex code flow.  As such
this is never going to be an acceptable change in the kernel.

Sorry Markus, but all patches have to pass a test on whether
any advantages to outweight complexity  This is definitely not
true here.

Again, a general kernel development rule is to float only one
patch of a given type until you have had feedback on it.  These
backwards goto cases are sufficiently different from your earlier
patch that got reviews that, at most, you should have sent one to the
list and then given time for it to be properly reviewed (up to a week
on IIO list typically).  That would have saved your time and mine.

As I said in one of the other patches, I always reply to all
patches I am rejecting so that anyone coming across them later
on their own from an archive or similar can immediately see the
reasons why they are a bad idea without having to know the mailing
list context.

Jonathan

> ---
>  drivers/iio/accel/stk8ba50.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
> index 576b6b140f08..afe90567ad37 100644
> --- a/drivers/iio/accel/stk8ba50.c
> +++ b/drivers/iio/accel/stk8ba50.c
> @@ -426,16 +426,13 @@ static int stk8ba50_probe(struct i2c_client *client,
>  	/* Set up interrupts */
>  	ret = i2c_smbus_write_byte_data(client,
>  			STK8BA50_REG_INTEN2, STK8BA50_DREADY_INT_MASK);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "failed to set up interrupts\n");
> -		goto err_power_off;
> -	}
> +	if (ret)
> +		goto report_failure;
> +
>  	ret = i2c_smbus_write_byte_data(client,
>  			STK8BA50_REG_INTMAP2, STK8BA50_DREADY_INT_MAP);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "failed to set up interrupts\n");
> -		goto err_power_off;
> -	}
> +	if (ret)
> +		goto report_failure;
>  
>  	if (client->irq > 0) {
>  		ret = devm_request_threaded_irq(&client->dev, client->irq,
> @@ -495,6 +492,10 @@ static int stk8ba50_probe(struct i2c_client *client,
>  err_power_off:
>  	stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
>  	return ret;
> +
> +report_failure:
> +	dev_err(&client->dev, "failed to set up interrupts\n");
> +	goto err_power_off;

Simple code flow is replaced by more complex flow for little gain.
Not a good idea.

>  }
>  
>  static int stk8ba50_remove(struct i2c_client *client)

