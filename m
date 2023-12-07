X-Greylist: delayed 142 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Dec 2023 10:58:47 PST
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C00610F9;
	Thu,  7 Dec 2023 10:58:47 -0800 (PST)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 410A9801F7;
	Thu,  7 Dec 2023 18:58:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id A25171A;
	Thu,  7 Dec 2023 18:58:39 +0000 (UTC)
Message-ID: <26ceceaec7dfe109b43c8677f74d91c5c893ac60.camel@perches.com>
Subject: Re: [PATCH v3 13/13] MAINTAINERS: Add MAINTAINERS entry for AD7091R
From: Joe Perches <joe@perches.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com, 
 dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, paul.cercueil@analog.com,
  Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
  dan.carpenter@linaro.org, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 07 Dec 2023 10:58:38 -0800
In-Reply-To: <b55d378dd8b6dbe787a83b5a0a1f3f05b2530eab.1701971344.git.marcelo.schmitt1@gmail.com>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
	 <b55d378dd8b6dbe787a83b5a0a1f3f05b2530eab.1701971344.git.marcelo.schmitt1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: kxqmrhecpbp8rrfygtoxcukpefw3woyr
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: A25171A
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/3NwuE18cfhVHEcK6vs+EyQ+1MnrtfxDk=
X-HE-Tag: 1701975519-182943
X-HE-Meta: U2FsdGVkX18+J42L2hwAsDCsmGB+Rg7Bix3MeDWX7Teb+C69tUX9anU45klsBarWWpuCDaqa747aFttNZ/nmfuXaZYXW/nQc+WvHWmSbZXEPRlebaODfW/DOG/9W6kohoy0NTvClAebSUky/V1JA1ob1AJsbJX5dMd9BWTberEvPqGuZZqwrhhjqIOiuveXhAYr2UMjRwoYd4zsj15zNvap/9vtoVhD0VsdZYNQaSZchmV6YYuicTpVkYSLGfY2Z6TR4p3O1IeRf3ah7bCjDjTdtdH3E29D6IqWvF2CJgeDgnLFS0TrSX7ZefB5lLNFTisvliB08PCml9EPYXWMjY1KHSRGCu1aBqeSYP8JPe1aapzTjsre2pk8U4ePtfY6HcO/acMZ4T/XoVK+xxfH3PFouclB9MJIP/wjJkW43i5XMoktSt6nJsg/AH+NLGBxG

On Thu, 2023-12-07 at 15:43 -0300, Marcelo Schmitt wrote:
> The driver for AD7091R was added in
> ca693001: iio: adc: Add support for AD7091R5 ADC
> but no MAINTAINERS file entry was added for it since then.
> Add a proper MAINTAINERS file entry for the AD7091R driver.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -1126,6 +1126,18 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4=
130
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>  F:	drivers/iio/adc/ad4130.c
> =20
> +ANALOG DEVICES INC AD7091R DRIVER
> +M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	http://ez.analog.com/community/linux-device-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
> +F:	drivers/iio/adc/drivers/iio/adc/ad7091r-base.c
> +F:	drivers/iio/adc/drivers/iio/adc/ad7091r-base.h
> +F:	drivers/iio/adc/drivers/iio/adc/ad7091r5.c
> +F:	drivers/iio/adc/drivers/iio/adc/ad7091r8.c

Maybe use wildcards?

F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r*
F:	drivers/iio/adc/drivers/iio/adc/ad7091r*


