Return-Path: <SRS0=I9Yo=EG=st.com=arnaud.pouliquen@kernel.org>
Subject: Re: [PATCH] IIO: ADC: stm32-dfsdm: avoid unused-variable warning
To: Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Mark
 Brown <broonie@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Hartmut Knaack
	<knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>,
        Alexandre Torgue
	<alexandre.torgue@st.com>
References: <20180111103510.1408292-1-arnd@arndb.de>
 <866335ff-d9a8-99c0-0946-82b3f207f266@arm.com>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <838ace12-2722-33aa-0ed8-2e8e7494b2ae@st.com>
Date: Thu, 11 Jan 2018 18:38:49 +0100
MIME-Version: 1.0
In-Reply-To: <866335ff-d9a8-99c0-0946-82b3f207f266@arm.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>



On 01/11/2018 03:27 PM, Robin Murphy wrote:
> On 11/01/18 10:34, Arnd Bergmann wrote:
>> Building with CONFIG_OF disabled produces a compiler warning:
>>
>> drivers/iio/adc/stm32-dfsdm-core.c: In function 'stm32_dfsdm_probe':
>> drivers/iio/adc/stm32-dfsdm-core.c:245:22: error: unused variable
>> 'pnode' [-Werror=unused-variable]
>>
>> This removes the variable and open-codes it in the only place
>> it gets used to avoid that warning.
>>
>> Fixes: bed73904e76f ("IIO: ADC: add stm32 DFSDM core support")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   drivers/iio/adc/stm32-dfsdm-core.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c
>> b/drivers/iio/adc/stm32-dfsdm-core.c
>> index 72427414db7f..6cd655f8239b 100644
>> --- a/drivers/iio/adc/stm32-dfsdm-core.c
>> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
>> @@ -242,7 +242,6 @@ MODULE_DEVICE_TABLE(of, stm32_dfsdm_of_match);
>>   static int stm32_dfsdm_probe(struct platform_device *pdev)
>>   {
>>       struct dfsdm_priv *priv;
>> -    struct device_node *pnode = pdev->dev.of_node;
>>       const struct of_device_id *of_id;
>>       const struct stm32_dfsdm_dev_data *dev_data;
>>       struct stm32_dfsdm *dfsdm;
>> @@ -254,7 +253,7 @@ static int stm32_dfsdm_probe(struct
>> platform_device *pdev)
>>         priv->pdev = pdev;
>>   -    of_id = of_match_node(stm32_dfsdm_of_match, pnode);
>> +    of_id = of_match_node(stm32_dfsdm_of_match, pdev->dev.of_node);
>>       if (!of_id->data) {
>>           dev_err(&pdev->dev, "Data associated to device is missing\n");
>>           return -EINVAL;
> 
> FWIW, it looks like this whole lot could be cleaned up by using
> of_device_get_match_data().
> 
Right, and test of the return now seems to me an overprotection as data
structure is defined in the driver...

Same optimization could be applied to stm32_dfsdm_adc_probe function.

Here is the patch I tested:

---
 drivers/iio/adc/stm32-dfsdm-adc.c  | 9 +--------
 drivers/iio/adc/stm32-dfsdm-core.c | 9 +--------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c
b/drivers/iio/adc/stm32-dfsdm-adc.c
index b03ca3f..01836c9 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1087,18 +1087,11 @@ static int stm32_dfsdm_adc_probe(struct
platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	const struct stm32_dfsdm_dev_data *dev_data;
 	struct iio_dev *iio;
-	const struct of_device_id *of_id;
 	char *name;
 	int ret, irq, val;

-	of_id = of_match_node(stm32_dfsdm_adc_match, np);
-	if (!of_id->data) {
-		dev_err(&pdev->dev, "Data associated to device is missing\n");
-		return -EINVAL;
-	}
-
-	dev_data = (const struct stm32_dfsdm_dev_data *)of_id->data;

+	dev_data = of_device_get_match_data(dev);
 	iio = devm_iio_device_alloc(dev, sizeof(*adc));
 	if (IS_ERR(iio)) {
 		dev_err(dev, "%s: Failed to allocate IIO\n", __func__);
diff --git a/drivers/iio/adc/stm32-dfsdm-core.c
b/drivers/iio/adc/stm32-dfsdm-core.c
index 7242741..6290332 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -242,8 +242,6 @@ MODULE_DEVICE_TABLE(of, stm32_dfsdm_of_match);
 static int stm32_dfsdm_probe(struct platform_device *pdev)
 {
 	struct dfsdm_priv *priv;
-	struct device_node *pnode = pdev->dev.of_node;
-	const struct of_device_id *of_id;
 	const struct stm32_dfsdm_dev_data *dev_data;
 	struct stm32_dfsdm *dfsdm;
 	int ret;
@@ -254,13 +252,8 @@ static int stm32_dfsdm_probe(struct platform_device
*pdev)

 	priv->pdev = pdev;

-	of_id = of_match_node(stm32_dfsdm_of_match, pnode);
-	if (!of_id->data) {
-		dev_err(&pdev->dev, "Data associated to device is missing\n");
-		return -EINVAL;
-	}
+	dev_data = of_device_get_match_data(&pdev->dev);

-	dev_data = (const struct stm32_dfsdm_dev_data *)of_id->data;
 	dfsdm = &priv->dfsdm;
 	dfsdm->fl_list = devm_kcalloc(&pdev->dev, dev_data->num_filters,
 				      sizeof(*dfsdm->fl_list), GFP_KERNEL);
-- 

Arnd,
fell free to propose it (with my acked-by) or tell me if you
prefer that i send it.

Thanks,
Arnaud
