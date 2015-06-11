Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:33087 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939AbbFKMxz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 11 Jun 2015 08:53:55 -0400
MIME-Version: 1.0
In-Reply-To: <20150611120635.GA15709@Inspiron>
References: <20150611120635.GA15709@Inspiron>
Date: Thu, 11 Jun 2015 15:53:53 +0300
Message-ID: <CAEnQRZAohOqQMfVPghEviY4kyCeT8JnuwpwKd63VhjwUPdsJLg@mail.gmail.com>
Subject: Re: [PATCH] iio: Fix parameters in iio_triggered_buffer_setup
From: Daniel Baluta <daniel.baluta@intel.com>
To: Cristina Opriceana <cristina.opriceana@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jun 11, 2015 at 3:06 PM, Cristina Opriceana
<cristina.opriceana@gmail.com> wrote:
> This patch renames the top half handler and the bottom half handler
> of iio_triggered_buffer_setup() in accordance with their usage.
> The names of the parameters were swapped, thus creating confusion.
>
> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

Thanks Cristina!

Daniel.
