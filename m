Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:46065 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbbKHX6r (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Nov 2015 18:58:47 -0500
Subject: Re: [PATCH v4 1/1] iio: pulsedlight-lidar-lite: add runtime PM
To: Matt Ranostay <mranostay@gmail.com>, jic23@kernel.org
References: <1447014418-27849-1-git-send-email-mranostay@gmail.com>
 <1447014418-27849-2-git-send-email-mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <563FE1AF.3040305@samsung.com>
Date: Mon, 09 Nov 2015 08:58:39 +0900
MIME-version: 1.0
In-reply-to: <1447014418-27849-2-git-send-email-mranostay@gmail.com>
Content-type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09.11.2015 05:26, Matt Ranostay wrote:
> Add runtime PM support for the lidar-lite module to enable low power
> mode when last device requested reading is over a second.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 54 ++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof


