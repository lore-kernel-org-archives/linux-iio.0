Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:2924 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752091AbdADRyP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 4 Jan 2017 12:54:15 -0500
Date: Wed, 4 Jan 2017 09:55:17 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] iio: adc: axp288: Drop bogus AXP288_ADC_TS_PIN_CTRL
 register modifications
Message-ID: <20170104095517.6f7ee610@jacob-builder>
In-Reply-To: <221c8f4e-0757-19bb-90db-4e34677734c5@redhat.com>
References: <20161214135525.16477-1-hdegoede@redhat.com>
        <1f31b2e7-90fa-0fb8-5f6e-a8ee2ddf69f7@kernel.org>
        <20161230101501.06958c0d@jacob-builder>
        <054b52de-40fd-a879-7b8e-2d25fed18840@redhat.com>
        <20170103102343.735dbdd1@jacob-builder>
        <221c8f4e-0757-19bb-90db-4e34677734c5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 3 Jan 2017 23:10:57 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> > It could have been a quirk we had to do on our platforms, I just
> > cannot recall the details. Are you testing this on x86 platforms?  
> 
> Yes, I've successfully tested this on 2 different models cherrytrail
> tablets.

[Jacob Pan] I am ok with your change. I last tested on baytrail
tablets, I don't know if you have one available to verify. That would
be ideal.

Thanks,
