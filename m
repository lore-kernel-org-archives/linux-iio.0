Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:51255 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276Ab3HSKNt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 19 Aug 2013 06:13:49 -0400
Date: Mon, 19 Aug 2013 12:13:48 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 1/1] Add Microchip MCP3422/3/4 high resolution ADC
In-Reply-To: <1376906769-12293-1-git-send-email-angelo.compagnucci@gmail.com>
Message-ID: <alpine.DEB.2.01.1308191212490.7929@pmeerw.net>
References: <1376906769-12293-1-git-send-email-angelo.compagnucci@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Patch now exposes the sample frequency via IIO_CHAN_INFO_SAMP_FREQ, 
> removes the unneeded locking logic for pga values and other minor fixes.
> 
> To Peter: Datasheet for this chip indexes the channels starting from 1 instead of 0.
> I thought it was better to stick to the datasheet conventions.

there would be datasheet_name in iio_chan_spec

p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
