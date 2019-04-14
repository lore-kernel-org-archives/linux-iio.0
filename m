Return-Path: <SRS0=A0tK=SQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=BIGNUM_EMAILS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAF9C10F13
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 12:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA9E2084E
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 12:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbfDNMr3 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 14 Apr 2019 08:47:29 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:46392 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfDNMr3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Apr 2019 08:47:29 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 888AC9E6A65;
        Sun, 14 Apr 2019 13:47:27 +0100 (BST)
Date:   Sun, 14 Apr 2019 13:47:24 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     paresh.chaudhary@rockwellcollins.com, linux-iio@vger.kernel.org
Subject: Re: [bug report] iio:temperature: Add MAX31856 thermocouple support
Message-ID: <20190414134724.59c1a359@archlinux>
In-Reply-To: <20190409115955.GA16862@kadam>
References: <20190409115955.GA16862@kadam>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 9 Apr 2019 14:59:55 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> Hello Paresh Chaudhary,
> 
> The patch fb55a51310d1: "iio:temperature: Add MAX31856 thermocouple
> support" from Mar 26, 2019, leads to the following static checker
> warning:
> 
> 	drivers/iio/temperature/max31856.c:215 max31856_read_raw()
> 	error: uninitialized symbol 'ret'.
> 
> drivers/iio/temperature/max31856.c
>     185 static int max31856_read_raw(struct iio_dev *indio_dev,
>     186 			     struct iio_chan_spec const *chan,
>     187 			     int *val, int *val2, long mask)
>     188 {
>     189 	struct max31856_data *data = iio_priv(indio_dev);
>     190 	int ret;
>     191 
>     192 	switch (mask) {
>     193 	case IIO_CHAN_INFO_RAW:
>     194 		ret = max31856_thermocouple_read(data, chan, val);
>     195 		if (ret)
>     196 			return ret;
>     197 		return IIO_VAL_INT;
>     198 	case IIO_CHAN_INFO_SCALE:
>     199 		switch (chan->channel2) {
>     200 		case IIO_MOD_TEMP_AMBIENT:
>     201 			/* Cold junction Temp. Data resolution is 0.015625 */
>     202 			*val = 15;
>     203 			*val2 = 625000; /* 1000 * 0.015625 */
>     204 			ret = IIO_VAL_INT_PLUS_MICRO;
>     205 			break;
>     206 		default:
>     207 			/* Thermocouple Temp. Data resolution is 0.0078125 */
>     208 			*val = 7;
>     209 			*val2 = 812500; /* 1000 * 0.0078125) */
>     210 			return IIO_VAL_INT_PLUS_MICRO;
>     211 		}
>     212 		break;
> 
> Smatch thinks mask can also IIO_CHAN_INFO_PROCESSED, IIO_CHAN_INFO_OFFSET,
> and IIO_CHAN_INFO_AVERAGE_RAW.  It often gets these function pointer
> calls a be merged together though.
> 
>     213 	}
>     214 
> --> 215 	return ret;  
>     216 }
> 
> regards,
> dan carpenter
Colin sent out a fix for this which does what is being suggested here.
I'll apply that.

Thanks,

Jonathan

