Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-025.synserver.de ([212.40.185.25]:1077 "EHLO
	smtp-out-025.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678AbbE2IHj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 May 2015 04:07:39 -0400
Message-ID: <55681E47.1000001@metafoo.de>
Date: Fri, 29 May 2015 10:07:35 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Kevin Tsai <ktsai@capellamicro.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Reyad Attiyat <reyad.attiyat@gmail.com>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: Add iio_mod_light_uva, iio_mod_light_uvb, and
 iio_mod_light_uvc.
References: <1432886683-7467-1-git-send-email-ktsai@capellamicro.com>
In-Reply-To: <1432886683-7467-1-git-send-email-ktsai@capellamicro.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/29/2015 10:04 AM, Kevin Tsai wrote:
> Add Ultraviolet(UV) support:
> UVA: 315 ~ 400 nm
> UVB: 280 ~ 315 nm
> UVC: 100 ~ 280 nm

We need documentation for these new modifiers in 
Documentation/ABI/testing/sys-bus-iio. Otherwise looks ok.

- Lars

