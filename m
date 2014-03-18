Return-Path: <k.kozlowski@samsung.com>
Message-id: <1395130095.13308.0.camel@AMDC1943>
Subject: Re: [PATCH] iio: cm36651: Fix i2c client leak and possible NULL
 pointer dereference
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Beomho Seo <beomho.seo@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 18 Mar 2014 09:08:15 +0100
In-reply-to: <53274BDA.9070804@kernel.org>
References: <1394098390-11213-1-git-send-email-k.kozlowski@samsung.com>
 <53247EC9.6090505@kernel.org> <1395043273.3950.3.camel@AMDC1943>
 <53274BDA.9070804@kernel.org>
Content-type: text/plain; charset=UTF-8
MIME-version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Mon, 2014-03-17 at 19:24 +0000, Jonathan Cameron wrote:
> On 17/03/14 08:01, Krzysztof Kozlowski wrote:
> > Hi,
> >
> > On Sat, 2014-03-15 at 16:24 +0000, Jonathan Cameron wrote:
> >> On 06/03/14 09:33, Krzysztof Kozlowski wrote:
> >>> During probe the driver allocates dummy I2C devices (i2c_new_dummy())
> >>> but they aren't unregistered during driver remove or probe failure.
> >>>
> >>> Additionally driver does not check the return value of i2c_new_dummy().
> >>> In case of error (i2c_new_device(): memory allocation failure or I2C
> >>> address cannot be used) this function returns NULL which is later
> >>> dereferenced by i2c_smbus_{read,write}_data() functions.
> >>>
> >>> Fix issues by properly checking for i2c_new_dummy() return value and
> >>> unregistering I2C devices on driver remove or probe failure.
> >>>
> >>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >> Good catch, but the error path needs more care.
> >>> ---
> >>>    drivers/iio/light/cm36651.c |   12 ++++++++++++
> >>>    1 file changed, 12 insertions(+)
> >>>
> >>> diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
> >>> index a45e07492db3..e7e9a597159f 100644
> >>> --- a/drivers/iio/light/cm36651.c
> >>> +++ b/drivers/iio/light/cm36651.c
> >>> @@ -653,6 +653,11 @@ static int cm36651_probe(struct i2c_client *client,
> >>>    	cm36651->ps_client = i2c_new_dummy(client->adapter,
> >>>    						     CM36651_I2C_ADDR_PS);
> >>>    	cm36651->ara_client = i2c_new_dummy(client->adapter, CM36651_ARA);
> >>> +	if (!cm36651->ps_client || !cm36651->ara_client) {
> >>> +		dev_err(&client->dev, "%s: new i2c device failed\n", __func__);
> >>> +		ret = -ENODEV;
> >>> +		goto error_i2c_unregister;
> >>> +	}
> >> The two failures need to be handled independently as we only want to unregister
> >> those that succeeded.  i2c_new_dummy will not return an error and leave a device
> >> registered.  This is particularly true given the first thing that i2c_unregister_device
> >> does is to derefence the client pointer.  That will cause a segfault if you do it
> >> for NULL as here.
> >>
> >
> > Where the segfault would occur? If i2c_new_dummy fails then
> > i2c_unregister_device() will be called only on NON-null values:
> > 	+error_i2c_unregister:
> > 	+	if (cm36651->ps_client)
> > 	+		i2c_unregister_device(cm36651->ps_client);
> > 	+	if (cm36651->ara_client)
> > 	+		i2c_unregister_device(cm36651->ara_client);
> >
> > If probe() succeeds (both i2c_new_dummy return proper pointer) then
> > remove() will unregister two i2c devices.
> >
> Oops, I missed that.  Still, the form of this is unusual so please
> change it to the more conventional option of a goto per error rather
> than grouping them.  That will also allow you to drop the null checks
> below leading to a more obviously correct error path.

Sure, I'll send a fixed version.

Best regards,
Krzysztof
