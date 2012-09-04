Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-43.csi.cam.ac.uk ([131.111.8.143]:44040 "EHLO
	ppsw-43.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756773Ab2IDL7l (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Sep 2012 07:59:41 -0400
Message-ID: <5045ED39.5030408@jic23.retrosnub.co.uk>
Date: Tue, 04 Sep 2012 12:59:53 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] staging:iio: Use iio_push_to_buffer
References: <1346758288-20031-1-git-send-email-lars@metafoo.de> <1346758519-23942-1-git-send-email-lars@metafoo.de> <alpine.DEB.2.01.1209041347230.11872@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1209041347230.11872@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/09/12 12:48, Peter Meerwald wrote:
>
>> Consistently use iio_push_to_buffer instead of manually calling the buffers
>> store_to callback.
>
> can we kill the timestamp parameter as an add-on patch?
>
> thanks, p.
>
Seems reasonable to me.

Jonathan
