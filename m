Return-Path: <SRS0=uIhB=UV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED05C43613
	for <linux-iio@archiver.kernel.org>; Sat, 22 Jun 2019 10:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48A2206BA
	for <linux-iio@archiver.kernel.org>; Sat, 22 Jun 2019 10:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfFVKwJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:52:09 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:51184 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfFVKwJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jun 2019 06:52:09 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 8FF989E74F4;
        Sat, 22 Jun 2019 11:52:07 +0100 (BST)
Date:   Sat, 22 Jun 2019 11:52:05 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     =?UTF-8?B?WmJ5bsSbaw==?= Kocur <zbynek.kocur@fel.cvut.cz>
Cc:     linux-iio@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>
Subject: Re: SRF04.c - wrong range for filter (line 145)
Message-ID: <20190622115205.767777c2@archlinux>
In-Reply-To: <B08A7378-8CBD-4B77-B18D-B0C157FAEC07@fel.cvut.cz>
References: <B08A7378-8CBD-4B77-B18D-B0C157FAEC07@fel.cvut.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

+CC Andreas.

On Mon, 17 Jun 2019 21:21:37 +0200
Zbyněk Kocur <zbynek.kocur@fel.cvut.cz> wrote:

> Hello,
> 
> I try to use linux kernel module for proximity sensor SRF04 and i was not able to measure distance longer than 1.5 m. The problem is on implementation maximum range filter in function srf04_read, line 145. The reasoning assumes that the distance to 3 meters is limited, but the direction back and forth is neglected. Therefore, the resulting limit is a maximum of 1.5 meres and not a required 3 meters. The solution is to come out of the formula:
> 
>                  *         distance       2 * 3 m
>                  * time = ---------- = --------- = 18808777 ns
>                  *          speed       319 m/s
>                  *
> 
> 
> Best Regards,
> Zbyněk Kocur
> ---
> email: zbynek.kocur@fel.cvut.cz
> phone: +420 224 354 054
> web: http://www.fel.cvut.cz
> Department of Telecommunications Engineering
> Faculty of Electrical Engineering
> 

