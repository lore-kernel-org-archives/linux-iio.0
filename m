Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-227.synserver.de ([212.40.185.227]:1074 "EHLO
	smtp-out-221.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751921AbaBNQLu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Feb 2014 11:11:50 -0500
Message-ID: <52FE404B.3050307@metafoo.de>
Date: Fri, 14 Feb 2014 17:11:55 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] iio:accel: call devm_iio_device_free function if
 common_proble fails
References: <1392391005-2719-1-git-send-email-denis.ciocca@st.com> <1392391005-2719-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1392391005-2719-2-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/14/2014 04:16 PM, Denis CIOCCA wrote:
> If st_accel_common_probe function fails, the device must be freed.
> Added devm_iio_device_free also on common_remove function.

When the device is allocated with devm_iio_device... you do not need to 
manually free the device. If probe fails the device will be freed automatically.

- Lars
