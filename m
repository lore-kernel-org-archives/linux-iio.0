Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43951 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbbJCJP6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Oct 2015 05:15:58 -0400
Subject: Re: [PATCH v2] [BUGFIX] iio: mlx96014: Error checking from positive
 to negative
To: Dan Carpenter <dan.carpenter@oracle.com>,
	Crt Mori <cmo@melexis.com>
References: <1443788661-31167-1-git-send-email-cmo@melexis.com>
 <20151002131926.GO7289@mwanda>
Cc: linux-iio@vger.kernel.org,
	Vianney le Clement de Saint-Marcq
	<vianney.leclement@essensium.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <560F9CCA.10307@kernel.org>
Date: Sat, 3 Oct 2015 10:15:54 +0100
MIME-Version: 1.0
In-Reply-To: <20151002131926.GO7289@mwanda>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/10/15 14:19, Dan Carpenter wrote:
> Thanks!
> 
> regards,
> dan carpenter
Applied to the togreg branch of iio.git as the problem patch
is currently only in staging-next.

Thanks,

Jonathan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

