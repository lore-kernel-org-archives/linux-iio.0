Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:38980 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753458Ab3JULsy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2013 07:48:54 -0400
Date: Mon, 21 Oct 2013 12:48:46 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Lukasz Czerwinski <l.czerwinski@samsung.com>
Cc: "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"denis.ciocca@st.com" <denis.ciocca@st.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"lee.jones@linaro.org" <lee.jones@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC v2 PATCH 01/14] iio: st_common: New interrupt interface
Message-ID: <20131021114845.GF8144@kartoffel>
References: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
 <1380299538-22047-2-git-send-email-l.czerwinski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1380299538-22047-2-git-send-email-l.czerwinski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Sep 27, 2013 at 05:32:05PM +0100, Lukasz Czerwinski wrote:
> This patch adds two interrupts handling by the st_common library.
> Additional second interrupt is used to indetify enabled event support for
> chosen ST device. It supports board files and dt.
> 
> For dt interface multiple interrupts are passed through interrupt-names
> property.
> 
> Read drdy_int_pin value is moved to the st_sensors_parse_platform_data()
> in the st_sensors_i2c.c and st_sensors_spi.c Now drdy_int_pin can be
> also configured via dt.
> 
> Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c |   36 +----------
>  drivers/iio/common/st_sensors/st_sensors_i2c.c  |   75 +++++++++++++++++++++-
>  drivers/iio/common/st_sensors/st_sensors_spi.c  |   77 ++++++++++++++++++++++-
>  include/linux/iio/common/st_sensors.h           |   13 +++-
>  include/linux/platform_data/st_sensors_pdata.h  |    2 +
>  5 files changed, 160 insertions(+), 43 deletions(-)
 
[...]

> +static void st_sensors_parse_platform_data(struct i2c_client *client,
> +               struct iio_dev *indio_dev)
> +{
> +       struct st_sensor_data *sdata = iio_priv(indio_dev);
> +       struct device_node *np = client->dev.of_node;
> +       struct st_sensors_platform_data *pdata = client->dev.platform_data;
> +
> +       if (pdata)
> +               sdata->drdy_int_pin = pdata->drdy_int_pin;
> +       else if (np)
> +               of_property_read_u8(np, "st,drdy-int-pin",
> +                       (u8 *)&sdata->drdy_int_pin);

Why the cast?

What are valid values for this propertyy and what does it mean?

No sanity checking? Are there 256 pins?

> +}
> +
> +static unsigned int st_sensors_i2c_map_irq(struct i2c_client *client,
> +               unsigned int irq_num)
> +{
> +       struct device_node *np = client->dev.of_node;
> +       struct st_sensors_platform_data *pdata = client->dev.platform_data;
> +       int index = 0;
> +
> +       if (pdata)
> +               return pdata->irqs[irq_num];
> +       else if (np) {
> +               switch (irq_num) {
> +               case ST_SENSORS_INT1:
> +                       index = of_property_match_string(np,
> +                                       "interrupt-names",
> +                                       ST_SENSORS_DRDY_IRQ_NAME);
> +                       break;
> +               case ST_SENSORS_INT2:
> +                       index = of_property_match_string(np,
> +                                       "interrupt-names",
> +                                       ST_SENSORS_EVENT_IRQ_NAME);
> +               default:
> +                       break;
> +               }
> +               return index < 0 ? 0 : irq_of_parse_and_map(np, index);
> +       }
> +       return 0;
> +}

Is there no platform_get_irq_byname equivalent for i2c devices? It seems like
naming the irq resources and using that would be a better solution.

Thanks,
Mark.
