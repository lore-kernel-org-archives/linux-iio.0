Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44211 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbbJCKHs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Oct 2015 06:07:48 -0400
Subject: Re: [PATCH 1/2] iio: fix drivers that use 0 as a valid IRQ in
 client->irq (part 2)
To: Octavian Purdila <octavian.purdila@intel.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
References: <1442998921-17665-1-git-send-email-octavian.purdila@intel.com>
 <1442998921-17665-2-git-send-email-octavian.purdila@intel.com>
Cc: srinivas.pandruvada@linux.intel.com, hadess@hadess.net,
	daniel.baluta@intel.com, irina.tirdea@intel.com, ao2@ao2.it,
	u.kleine-koenig@pengutronix.de, vlad.dogaru@intel.com,
	linus.walleij@linaro.org, tiberiu.a.breana@intel.com,
	javier@osg.samsung.com, dan.carpenter@oracle.com,
	geert@linux-m68k.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <560FA8F2.8040903@kernel.org>
Date: Sat, 3 Oct 2015 11:07:46 +0100
MIME-Version: 1.0
In-Reply-To: <1442998921-17665-2-git-send-email-octavian.purdila@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/09/15 10:02, Octavian Purdila wrote:
> Since commit dab472eb931bc291 ("i2c / ACPI: Use 0 to indicate that
> device does not have interrupt assigned") 0 is not a valid i2c
> client irq anymore, so change all driver's checks accordingly.
> 
> The same issue occurs when the device is instantiated via device tree
> with no IRQ, or from the i2c sysfs interface, even before the patch
> above.
> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Applied to the togreg branch of iio.git. Initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/stk8312.c  | 2 +-
>  drivers/iio/accel/stk8ba50.c | 2 +-
>  drivers/iio/light/stk3310.c  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
> index c764af2..a578694 100644
> --- a/drivers/iio/accel/stk8312.c
> +++ b/drivers/iio/accel/stk8312.c
> @@ -572,7 +572,7 @@ static int stk8312_probe(struct i2c_client *client,
>  	if (client->irq < 0)
>  		client->irq = stk8312_gpio_probe(client);
>  
> -	if (client->irq >= 0) {
> +	if (client->irq > 0) {
>  		ret = devm_request_threaded_irq(&client->dev, client->irq,
>  						stk8312_data_rdy_trig_poll,
>  						NULL,
> diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
> index 80f77d8..a59f5d8 100644
> --- a/drivers/iio/accel/stk8ba50.c
> +++ b/drivers/iio/accel/stk8ba50.c
> @@ -468,7 +468,7 @@ static int stk8ba50_probe(struct i2c_client *client,
>  	if (client->irq < 0)
>  		client->irq = stk8ba50_gpio_probe(client);
>  
> -	if (client->irq >= 0) {
> +	if (client->irq > 0) {
>  		ret = devm_request_threaded_irq(&client->dev, client->irq,
>  						stk8ba50_data_rdy_trig_poll,
>  						NULL,
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index 25c6a71..4e56c90 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -636,7 +636,7 @@ static int stk3310_probe(struct i2c_client *client,
>  		}
>  	}
>  
> -	if (client->irq >= 0) {
> +	if (client->irq > 0) {
>  		ret = devm_request_threaded_irq(&client->dev, client->irq,
>  						stk3310_irq_handler,
>  						stk3310_irq_event_handler,
> 

