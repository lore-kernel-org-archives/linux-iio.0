Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-249.synserver.de ([212.40.185.249]:1024 "EHLO
	smtp-out-249.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932080AbaLAUvK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Dec 2014 15:51:10 -0500
Message-ID: <547CD4C0.80304@metafoo.de>
Date: Mon, 01 Dec 2014 21:51:12 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/4] Add valid sample channel
References: <1416919687-14271-1-git-send-email-vlad.dogaru@intel.com>	<5474B01D.8020701@metafoo.de>	<CAEnQRZC_ax0n2b+pTiTVLk=0m+AzX7JkRHdB=8a70d8hQ3eD-Q@mail.gmail.com>	<5474B59B.8000101@metafoo.de>	<5D8E0479-F926-424A-B931-8A33BD99EC31@kernel.org>	<CAEnQRZBURtX3=d9-sy1AvgipgqcYTiiL5TCjaSwMkeJd-XYh0w@mail.gmail.com>	<547CCA2E.8010705@metafoo.de> <CAEnQRZAghZOXdut4vZr-HzRqhMSF3Dv+XccWAhY_NS65BxhUVg@mail.gmail.com>
In-Reply-To: <CAEnQRZAghZOXdut4vZr-HzRqhMSF3Dv+XccWAhY_NS65BxhUVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/01/2014 09:46 PM, Daniel Baluta wrote:
[...[
>>> User space application will read /dev/iio:deviceX to get data
>>> samples. How would they know the source of the data samples?
>>
>>
>> What exactly do you mean by source?
>
> By source I mean accelerometer or magnetometer in the case of KMX61 sensor.

The channel type of the iio device should make it pretty clear which one it 
is ;) You can also add a suffix to the IIO device name.

