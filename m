Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-084.synserver.de ([212.40.185.84]:1067 "EHLO
	smtp-out-084.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030334AbaLMLdK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Dec 2014 06:33:10 -0500
Message-ID: <548C23C0.8000701@metafoo.de>
Date: Sat, 13 Dec 2014 12:32:16 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
	Nikolaus Schulz <nikolaus.schulz@avionic-design.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Michael Welling <mwelling@ieee.org>,
	Philippe Reynes <tremyfr@yahoo.fr>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
CC: Alban Bedel <alban.bedel@avionic-design.de>
Subject: Re: [PATCH v2 2/2] iio: add driver for the TI DAC8554
References: <1416858614-32265-1-git-send-email-nikolaus.schulz@avionic-design.de> <1416858614-32265-2-git-send-email-nikolaus.schulz@avionic-design.de> <5482EA33.7020305@gmx.de>
In-Reply-To: <5482EA33.7020305@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/2014 12:36 PM, Hartmut Knaack wrote:
[...]
>> +static int dac8554_read_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int *val,
>> +			    int *val2,
>> +			    long m)
> Commonly, m is called mask (like you do in _write_raw).

We should call it info in new driver. It used to be a mask, but that was a 
long long time ago.

[...]
