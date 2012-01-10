Return-Path: <lars@metafoo.de>
Message-ID: <4F0C0B8A.7040309@metafoo.de>
Date: Tue, 10 Jan 2012 10:57:30 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Pirmin Duss <pirmin.duss@flytec.ch>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH V3.1] adds support for Texas Instruments ads1110 adc
References: <4F059EFC.5020902@metafoo.de> <1325842505-17619-1-git-send-email-pirmin.duss@flytec.ch>
In-Reply-To: <1325842505-17619-1-git-send-email-pirmin.duss@flytec.ch>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 01/06/2012 10:35 AM, Pirmin Duss wrote:
> From: Pirmin Duss (Flytec) <pirmin.duss@flytec.ch>
> 
[...]
> +
> +static struct i2c_driver ads1110_driver = {
> +	.driver = {
> +		.name = "ads1110",
> +	},
> +	.probe = ads1110_probe,
> +	.remove = __devexit_p(ads1110_remove),
> +	.id_table = ads1110_id,
> +};
> +
> +static int __init ads1110_init(void)
> +{
> +	return i2c_add_driver(&ads1110_driver);
> +}
> +module_init(ads1110_init);
> +
> +static void __exit ads1110_exit(void)
> +{
> +	i2c_del_driver(&ads1110_driver);
> +}
> +module_exit(ads1110_exit);

Now that staging-next contains this macro please use
module_i2c_driver(ads1110_driver) here.
