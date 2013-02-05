Return-Path: <linux@roeck-us.net>
Date: Tue, 5 Feb 2013 07:22:19 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Cc: devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Anton Vorontsov <cbou@mail.ru>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v3 2/2] iio: Add OF support
Message-ID: <20130205152219.GA15057@roeck-us.net>
References: <1360009566-26347-1-git-send-email-linux@roeck-us.net>
 <1360009566-26347-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360009566-26347-3-git-send-email-linux@roeck-us.net>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Feb 04, 2013 at 12:26:06PM -0800, Guenter Roeck wrote:
> Provide bindings and parse OF data during initialization.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> One open question is how to assign of_node to the iio device. We can either do it
> in each driver (which turns out to be a huge patchset), or add something like the
> following to iio_device_register.
> 
> 	if (!indio_dev->dev.of_node && indio_dev->dev.parent)
> 		indio_dev->dev.of_node = indio_dev->dev.parent->of_node;
> 
[ ... ]
> +
> +#else /* CONFIG_OF */
> +
> +static inline struct iio_channel *
> +of_iio_channel_get_by_name(struct device *dev, const char *name)
> +{
> +	return ERR_PTR(-ENOENT);
> +}
> +

The above should be

static inline struct iio_channel *
of_iio_channel_get_by_name(struct device_node *np, const char *name)
{
	return NULL;
}

Will be fixed in the next version.

Guenter
