Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:41652 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751060AbdCWWPI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 23 Mar 2017 18:15:08 -0400
Date: Thu, 23 Mar 2017 15:14:52 -0700
From: Tony Lindgren <tony@atomide.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv2] iio: adc: cpcap: Add minimal support for CPCAP PMIC ADC
Message-ID: <20170323221452.GU10760@atomide.com>
References: <20170322233726.5391-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170322233726.5391-1-tony@atomide.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [170322 16:39]:
> +/**
> + * enum cpcap_adc_type - cpcap adc types
> + *
> + * Two banks of channels with eight channels in each. The first two channels
> + * in bank0 can be muxed for other functionality with CPCAP_ADC_TYPE_BATT_PI.
> + */
> +enum cpcap_adc_type {
> +	CPCAP_ADC_TYPE_BANK_0,
> +	CPCAP_ADC_TYPE_BANK_1,
> +	CPCAP_ADC_TYPE_BATT_PI,
> +};

Hmm looks like I only got half done yesterday.. I can now get
rid of the above in favor of using just channels.

> +static void cpcap_adc_phase(struct cpcap_adc_request *req, int index)
> +{
> +	const struct cpcap_adc_conversion_tbl *conv_tbl;
> +	const struct cpcap_adc_phasing_tbl *phase_tbl;
> +	int tbl_index;
> +
> +	switch (req->type) {
> +	case CPCAP_ADC_TYPE_BANK_0:
> +		conv_tbl = bank0_conversion;
> +		phase_tbl = bank0_phasing;
> +		tbl_index = index;
> +		break;
> +	case CPCAP_ADC_TYPE_BANK_1:
> +		conv_tbl = bank1_conversion;
> +		phase_tbl = bank1_phasing;
> +		tbl_index = index;
> +		break;
> +	case CPCAP_ADC_TYPE_BATT_PI:
> +		conv_tbl = bank0_conversion;
> +		phase_tbl = bank0_phasing;
> +		tbl_index = (index % 2) ? CPCAP_ADC_BATTI :
> +			CPCAP_ADC_BATTP;
> +		break;
> +	default:
> +		return;
> +	}

And then the above switch will go away.

> +static void cpcap_adc_convert(struct cpcap_adc_request *req, int index)
> +{
> +	const struct cpcap_adc_conversion_tbl *conv_tbl;
> +	int tbl_index;
> +
> +	switch (req->type) {
> +	case CPCAP_ADC_TYPE_BANK_0:
> +		conv_tbl = bank0_conversion;
> +		tbl_index = index;
> +		break;
> +	case CPCAP_ADC_TYPE_BANK_1:
> +		conv_tbl = bank1_conversion;
> +		tbl_index = index;
> +		break;
> +	case CPCAP_ADC_TYPE_BATT_PI:
> +		conv_tbl = bank0_conversion;
> +		tbl_index = (index % 2) ?
> +			CPCAP_ADC_BATTI : CPCAP_ADC_BATTP;
> +		break;
> +	default:
> +		return;
> +	}

And here too.

> +static int cpcap_adc_init_request(struct cpcap_adc_request *req,
> +				  int channel)
> +{
> +	switch (channel) {
> +	case 0 ... 7:
> +		req->bank_index = channel;
> +		req->type = CPCAP_ADC_TYPE_BANK_0;
> +		break;
> +	case 8 ... 15:
> +		req->bank_index = channel - 8;
> +		req->type = CPCAP_ADC_TYPE_BANK_1;
> +		break;
> +	case 16 ... 17:
> +		req->bank_index = channel - 16;
> +		req->type = CPCAP_ADC_TYPE_BATT_PI;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

And this can be done by indexing everything with just the
channels. So I'll be posting v3 of this patch at some point
hopefully later on today.

Regards,

Tony
