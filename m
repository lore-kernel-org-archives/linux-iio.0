Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:33123 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbcBPEfk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2016 23:35:40 -0500
Received: by mail-yw0-f171.google.com with SMTP id u200so130621582ywf.0
        for <linux-iio@vger.kernel.org>; Mon, 15 Feb 2016 20:35:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1602151923540.7180@pmeerw.net>
References: <5764f4978abda151dd053c56d08f1688b371635d.1455557806.git.gregor.boirie@parrot.com>
 <alpine.DEB.2.02.1602151923540.7180@pmeerw.net>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
Date: Tue, 16 Feb 2016 02:28:49 -0200
Message-ID: <CAKi4VAL9=HSGQRG97c597_krDn=1L7bo3_8+DriONshnomSnAw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] iio:pressure:ms5611: fix ms5607 temp compensation
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Gregor Boirie <gregor.boirie@parrot.com>,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>, "Andrew F. Davis" <afd@ti.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Feb 15, 2016 at 4:37 PM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
>
>> See page 8 of ms5607 datasheet here:
>> http://www.meas-spec.com/product/pressure/MS5607-ms.aspx
>
> link doesn't seem to work anymore, maybe now it's
> http://www.meas-spec.com/product/pressure/MS5607-02BA03.aspx
>
> computation of sens2 was wrong and is fixed by this patch,
> sens2 should be 2 * (t - 2000)^2

yes, and it matches what we are currently doing in ardupilot.

Acked-by: Lucas De Marchi <lucas.demarchi@intel.com>


Lucas De Marchi
