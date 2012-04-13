Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-152.synserver.de ([212.40.185.152]:1029 "EHLO
	smtp-out-141.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754504Ab2DMKfx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 06:35:53 -0400
Message-ID: <4F880205.1030001@metafoo.de>
Date: Fri, 13 Apr 2012 12:37:57 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 13/13] staging:iio: drop procesed_val element of chan_spec.
References: <1334311471-23054-1-git-send-email-jic23@kernel.org> <1334311471-23054-14-git-send-email-jic23@kernel.org>
In-Reply-To: <1334311471-23054-14-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/13/2012 12:04 PM, Jonathan Cameron wrote:
> [...]
> +<<<<<<< HEAD
>   *			correspond to the first name that the channel is referred
>   *			to by in the datasheet (e.g. IND), or the nearest
>   *			possible compound name (e.g. IND-INC).
>   * @processed_val:	Flag to specify the data access attribute should be
>   *			*_input rather than *_raw.
> +=======
> + *			correspond to the first name that the channel is
> + *			referred to by in the datasheet (e.g. IND), or the
> + *			nearest	possible compound name (e.g. IND-INC).
> +>>>>>>> adbde46... staging:iio: drop procesed_val element of chan_spec.
>  [...]

Looks like something went wrong here.
