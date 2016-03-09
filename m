Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55862 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847AbcCIUbu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2016 15:31:50 -0500
Subject: Re: [PATCH 0/2] Add support for MAX31722/MAX31723 temperature sensors
To: Tiberiu Breana <tiberiu.a.breana@intel.com>,
	linux-iio@vger.kernel.org
References: <1457530252-4984-1-git-send-email-tiberiu.a.breana@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56E08834.40704@kernel.org>
Date: Wed, 9 Mar 2016 20:31:48 +0000
MIME-Version: 1.0
In-Reply-To: <1457530252-4984-1-git-send-email-tiberiu.a.breana@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/16 13:30, Tiberiu Breana wrote:
> This patch set adds support for the MAX31722/MAX31723 temperature sensors /
> thermostats.
> Patch 1 adds basic support and power management.
> Patch 2 adds threshold interrupt support.
> 
> Tiberiu Breana (2):
>   iio: temperature: Add support for MAX31722/MAX31723 temperature
>     sensors
>   iio: temperature: Add threshold interrupt support for max31722
> 
>  drivers/iio/temperature/Kconfig    |  12 +
>  drivers/iio/temperature/Makefile   |   1 +
>  drivers/iio/temperature/max31722.c | 673 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 686 insertions(+)
>  create mode 100644 drivers/iio/temperature/max31722.c
> 
Hi Tiberiu,

When proposing a temperature sensor driver, we need some additional justification
for why it is suited for IIO rather than the more focused (and in someways simpler)
hwmon.

So far we have had thermophiles that don't fit in as devices typically used for
hardware monitoring. Also in there are a few drivers which are for parts where
they are a cut down version of a more complex sensor (the measurement specialties
parts are either pressure sensors or humidty sensors at least in terms of what they
share interfaces with)

Also, please cc the hwmon maintainers (and probably list) as we want their agreement.

Jonathan
