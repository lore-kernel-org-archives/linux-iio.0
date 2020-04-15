Return-Path: <SRS0=VcbJ=57=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED43C2BB55
	for <linux-iio@archiver.kernel.org>; Wed, 15 Apr 2020 14:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C146208E4
	for <linux-iio@archiver.kernel.org>; Wed, 15 Apr 2020 14:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586961111;
	bh=9JkQAAV1ULc0kdgcHmQ1UJ8eYXsURDq4gxEG+XXAtvY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UmV+QacqvMEbTuzbHCWEQmW9bWdy/nf/MXwSoikDACKVup4+bZH9fhllY849D+URI
	 gdnk3mrfoZvPGgetygWGauBWGfdmlCfL7SgJSlJYl4UgqDuoFZSBUEj/W+xyFkJ5WX
	 jcahpHHrxZY1W7/ex4J7y+exa8O6tYHP68IDgv3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394065AbgDOObu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:31:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394053AbgDOObo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 15 Apr 2020 10:31:44 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE1F52076D;
        Wed, 15 Apr 2020 14:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961104;
        bh=9JkQAAV1ULc0kdgcHmQ1UJ8eYXsURDq4gxEG+XXAtvY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hKbpthBfa4h+9LTbnZq6MEXOLgoi3O+jKrp6zQhuVI3X69f8oBfT0gDUl0jhBA0xn
         yLBt2G4tzfQrQqBZ7buqWjln6iSRbFL+dIzfyFJA4k/2M0O6Q1kgTym7bqcMnBZdU8
         kOD7oYvBuMUqYO8RdsqlKEivAtwC9nmP8TPcFhKA=
Received: by mail-qt1-f169.google.com with SMTP id l60so4919881qtd.8;
        Wed, 15 Apr 2020 07:31:43 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ8wVZLvHQhAG2A9Gn9oxMQOwVCC3dYN8nvicif5IusqvYeJiV2
        S23bzMzUCGYVEhEodA/p0QY/bxeBQDcqHv4lZA==
X-Google-Smtp-Source: APiQypJHn2ieP+pZ3Cj6MwccmAylDwcIjDK4SRJo3RgsAbNBN4XrceT0De54TF1qdz1z7mq3w16vSgxfFB2hMgSSSL0=
X-Received: by 2002:ac8:7cba:: with SMTP id z26mr11770790qtv.143.1586961103061;
 Wed, 15 Apr 2020 07:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200324094506.55938-1-alexandru.tachici@analog.com>
In-Reply-To: <20200324094506.55938-1-alexandru.tachici@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 15 Apr 2020 09:31:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJyie7ZFPz5=qu5FMGDPrzX0=3HtyqCc_9Cpc=Jbd8b6A@mail.gmail.com>
Message-ID: <CAL_JsqJyie7ZFPz5=qu5FMGDPrzX0=3HtyqCc_9Cpc=Jbd8b6A@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/2] iio: dac: ad5770r: dt bindings fixes
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 24, 2020 at 4:45 AM <alexandru.tachici@analog.com> wrote:
>
> From: Alexandru Tachici <alexandru.tachici@analog.com>
>
> This aims to replace use of num property from dt nodes with
> reg property both in dt bindings and driver and fix
> dt bindings errors.
>
> 1. read from fwnode reg property instead of num property
>
> 2. replace num property with reg property and fix dt
> bindings errors
>
> Alexandru Tachici (2):
>   iio: dac: ad5770r: read channel nr from reg
>   dt-bindings: iio: dac: AD5570R fix bindings errors

Can I get a respin of this so it can be fixed for rc2. Or I can just revert.

Rob
