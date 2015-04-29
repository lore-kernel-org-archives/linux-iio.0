Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:34795 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476AbbD2K1v (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Apr 2015 06:27:51 -0400
Message-ID: <1430303267.2525.94.camel@hadess.net>
Subject: Re: [PATCH 2/3] iio: accel: kxcjk-1013: rename is_smo8500_device to
 polling_mode
From: Bastien Nocera <hadess@hadess.net>
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Date: Wed, 29 Apr 2015 12:27:47 +0200
In-Reply-To: <1430298111-20127-3-git-send-email-ao2@ao2.it>
References: <1430298111-20127-1-git-send-email-ao2@ao2.it>
	 <1430298111-20127-3-git-send-email-ao2@ao2.it>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2015-04-29 at 11:01 +0200, Antonio Ospite wrote:
> The purpose of the variable is to remember when an interrupt cannot 
> be
> requested and hence the driver must work in polling mode, so tell 
> that
> instead of mentioning the specific case when this is needed.
> 
> This makes the variable name to be still meaningful when some other
> devices requiring this show up.
> 
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Bastien Nocera <hadess@hadess.net>
> Cc: linux-iio@vger.kernel.org

Completely fine with that.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
