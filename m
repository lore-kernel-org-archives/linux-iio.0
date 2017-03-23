Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:58430 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbdCWL72 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Mar 2017 07:59:28 -0400
Subject: Re: [PATCH] staging: tsl2x7x: Moved contents of the header to the
 source file.
To: Arushi Singhal <arushisinghal19971997@gmail.com>, jic23@kernel.org
References: <20170323115357.GA24360@arushi-HP-Pavilion-Notebook>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <d432970a-ffea-2cce-de3e-db4f30f0201f@metafoo.de>
Date: Thu, 23 Mar 2017 12:59:22 +0100
MIME-Version: 1.0
In-Reply-To: <20170323115357.GA24360@arushi-HP-Pavilion-Notebook>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/23/2017 12:53 PM, Arushi Singhal wrote:
> Moved the contents of the header(tsl2x7x.h) into the source file
> tsl2x7x_core.c with the exception of the platform data struct which is
> supposed to be used from somewhere else other than the driver.

The platform_data struct uses the other structs though.
