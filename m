Return-Path: <SRS0=IAzx=EM=gmail.com=arndbergmann@kernel.org>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <8dd30c35-011c-1d0f-7331-76df8fcd0c23@st.com>
References: <20180117144644.2302131-1-arnd@arndb.de> <8dd30c35-011c-1d0f-7331-76df8fcd0c23@st.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Jan 2018 21:09:19 +0100
Message-ID: <CAK8P3a2_g+cPjZgv=_c=VunV+eCVPkFn7mYSxqKD_LqNdrLUBw@mail.gmail.com>
Subject: Re: [PATCH] IIO: ADC: stm32-dfsdm: remove unused variable
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@st.com>, linux-iio@vger.kernel.org,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jan 17, 2018 at 4:27 PM, Arnaud Pouliquen
<arnaud.pouliquen@st.com> wrote:
> Hi Arnd,
>
> On 01/17/2018 03:46 PM, Arnd Bergmann wrote:
>> A cleanup left one variable behind that is no longer needed and
>> can be removed, as shown by the gcc warning:
>>
>> drivers/iio/adc/stm32-dfsdm-core.c: In function 'stm32_dfsdm_probe':
>> drivers/iio/adc/stm32-dfsdm-core.c:245:29: error: unused variable 'of_id' [-Werror=unused-variable]
>>
>> Fixes: abaca806fd13 ("IIO: ADC: stm32-dfsdm: code optimization")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/iio/adc/stm32-dfsdm-core.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
>> index 84277bcc465f..6290332cfd3f 100644
>> --- a/drivers/iio/adc/stm32-dfsdm-core.c
>> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
>> @@ -242,7 +242,6 @@ MODULE_DEVICE_TABLE(of, stm32_dfsdm_of_match);
>>  static int stm32_dfsdm_probe(struct platform_device *pdev)
>>  {
>>       struct dfsdm_priv *priv;
>> -     const struct of_device_id *of_id;
>>       const struct stm32_dfsdm_dev_data *dev_data;
>>       struct stm32_dfsdm *dfsdm;
>>       int ret;
>>
> Could you crosscheck? This is included in the patch:
> https://www.spinics.net/lists/arm-kernel/msg628841.html applied in
> Mark's branches ( commit abaca806fd13afd069e04e883de8ec75924b0598)

The problem appears to have come from a mismerge in commit d84b4c7c706f
("Merge branch 'topic/iio' of
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound
into asoc-st-dfsdm"). abaca806fd13 was fine, but when Mark merged it into
his branch, it seems there was a conflict because both sides contained
a copy of my earlier patch 2353758bc2d4 ("IIO: ADC: stm32-dfsdm: avoid
unused-variable warning") and 25140717414c, plus one had your
abaca806fd1 patch on top.

So my patch is correct, but my the 'Fixes' line in the description is wrong,
it should have an explanation about the mismerge.

Mark, not sure how you want to proceed from here: if this is a branch
that can get rebased, it might be best to do that merge again, or even
drop one of the two copies of my earlier patch. Otherwise I can send
a new version of the fix with an updated explanation.

      Arnd
