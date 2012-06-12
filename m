Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44653 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab2FLVud (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jun 2012 17:50:33 -0400
Received: by dady13 with SMTP id y13so25323dad.19
        for <linux-iio@vger.kernel.org>; Tue, 12 Jun 2012 14:50:33 -0700 (PDT)
Date: Tue, 12 Jun 2012 14:50:30 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: add mcp4725 I2C DAC driver
Message-ID: <20120612215030.GA1625@kroah.com>
References: <1339171605-2577-1-git-send-email-pmeerw@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339171605-2577-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Jun 08, 2012 at 06:06:45PM +0200, Peter Meerwald wrote:
> v5:
> * fix warnings (Jonathan Cameron)
> 
> v4:
> * remove unused indio_dev pointer in mcp4725_data (Jonathan Cameron)
> * use u16 instead of unsigned short in mcp4725_data (Jonathan Cameron)
> * #include mcp4725.h from linux/iio/dac/

Shouldn't that file be in include/linux/platform_data/ instead?  It
really doesn't have anything to do with iio specifically.

Oh, nevermind, all the other drivers put their platform data in that
directory already, so I guess it's ok.  But it might be nice to move all
of them out of there soon...

thanks,

greg k-h
