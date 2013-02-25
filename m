Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-129.synserver.de ([212.40.185.129]:1191 "EHLO
	smtp-out-124.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932363Ab3BYKGx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Feb 2013 05:06:53 -0500
Message-ID: <512B381C.1030201@metafoo.de>
Date: Mon, 25 Feb 2013 11:08:28 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Carsten Frank <Carsten.Frank@haw-hamburg.de>
CC: linux-iio@vger.kernel.org
Subject: Re: driver interface for usb spectrometer (like OceanOptics)
References: <5127353B.1040801@haw-hamburg.de>
In-Reply-To: <5127353B.1040801@haw-hamburg.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/22/2013 10:07 AM, Carsten Frank wrote:
> Hi all.
> 
> I have written drivers to access Hamamatsu and Avantes usb-spectrometers
> which express the the following interfaces:
> One is located in a subdiretory in the the "/sys/bus/usb/drivers/" tree and
> the other on can be foud in the /dev/ directory.
> 
> The first is used to configure the spectrometer (e.g. integration_time,
> gain, etc.) and used to show information like the temperature or the
> wavelength calibration parameters.
> 
> The interface in /dev/ is used to aquire the data from the spectrometer
> (typically 2048 x 2 bytes).
> 
> Greg (K-H) suggests that the iio interface may be an option so I would like
> to get some opinions.
> 
> Thank you very much in advance,
> 
> Carsten

Hi,

I don't think we have any spectrometer devices in IIO yet. But it could be a
fit, maybe requires some extensions to the current IIO API though. Have you
looked at the IIO API and userspace ABI to see how your device could fit in
there?

Also what does the data returned by the spectrometer look like? Usually the
data returned by an IIO device is in some kind of standardized form, so
generic applications can be written without having to know the exact data
layout the device uses.

I'm not an expert on how spectrometers work, what kind of parameters they
have and what the result of a 'conversion' looks like. Maybe you could give
a short introduction, this would certainly make it easier to figure out how
this would fit into IIO.
A pointer to the sourcecode of the current driver could also be useful.

- Lars
