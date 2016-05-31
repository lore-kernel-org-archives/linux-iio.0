Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:41579 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbcEaOLQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 31 May 2016 10:11:16 -0400
Subject: Re: [RFC 4/7] iio: Add current_trigger_id alternative
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <cover.1464027859.git.leonard.crestez@intel.com>
 <0f8ba32f5714db12b798621cb805636d29a1aa02.1464027859.git.leonard.crestez@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <574D9B7D.3020101@metafoo.de>
Date: Tue, 31 May 2016 16:11:09 +0200
MIME-Version: 1.0
In-Reply-To: <0f8ba32f5714db12b798621cb805636d29a1aa02.1464027859.git.leonard.crestez@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/23/2016 08:39 PM, Crestez Dan Leonard wrote:
> This allows controlling the current trigger by numeric ID rather than
> name.

This is most certainly the far better interface, but so far we've tried to
have only one way to do a certain task with the IIO userspace ABI and try to
live with our mistakes of the past.

And while this is the better interface I don't think it is that much better
that it justifies the ambiguity that is introduced by it.

Adding a new interface makes only sense in my opinion if there is a
significant improvement in either usability or performance.
