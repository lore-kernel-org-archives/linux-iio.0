Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:39693 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab1DDNR2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Apr 2011 09:17:28 -0400
Message-ID: <4D99C548.4060103@cam.ac.uk>
Date: Mon, 04 Apr 2011 14:19:04 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] IIO: DAC: New driver for the AD5504 and AD55041 High
 Voltage DACs
References: <1301921093-21122-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1301921093-21122-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/04/11 13:44, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Changes since V1:
> 
> IIO: DAC: Apply review feedback from Jonathan
> 
> Fix array size and declare const.
> Fix reversed dacY_powerdown read back.
> Use individual attribute groups instead of is_visible.
> Fix event naming and add the _en file.
> 
> Changes since V2:
> 
> IIO: DAC: AD5504 use proper event type
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

