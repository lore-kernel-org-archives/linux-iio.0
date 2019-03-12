Return-Path: <SRS0=PpOZ=RP=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388EEC43381
	for <linux-iio@archiver.kernel.org>; Tue, 12 Mar 2019 12:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0697220657
	for <linux-iio@archiver.kernel.org>; Tue, 12 Mar 2019 12:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFJPM4fG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfCLMcZ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:32:25 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45129 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfCLMcZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Mar 2019 08:32:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id v20so2200598qtv.12
        for <linux-iio@vger.kernel.org>; Tue, 12 Mar 2019 05:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=P7tyYSfp5Vnf8f4l1nwHJUJuGhCUNuT7cL2lyu/EEs4=;
        b=eFJPM4fG+7J6ulC2ZMP5JqUIFGs6ol8ssIWhiMkT1lmrozMCnYSvrtgVXXsz6AOob7
         vOs+MMBcyP3t472zPbCJNZ/nQQvj/N4tF99Wa16kO+Mi8S7r6GKMJuMIjSXxrjjn/Rf/
         b0t/OlmphuMlLV0YYm3ZmSRaMTQx770uVYeshal0xVq3ClBd6jIaZQaCVriwY3VjwoFI
         17kirqNpediB+TG7BjKjdD/BiOJDcQn/wJkrHzLb3hGHlrNeNCq9wKXBrt8xf0DDfdWS
         TSKveA1TkBftqX0K6tR9U/Za/pUjirdDTxoauSXBzCnW+3IzwilkHrsn2BrlevNemVh+
         nMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=P7tyYSfp5Vnf8f4l1nwHJUJuGhCUNuT7cL2lyu/EEs4=;
        b=X8WZX+bV+dkQ0Vwg9FG57uoA44uiDrlHD+zZHyvAz5f3nRV7g5pjzst4Ye8MWtEHas
         J5nDGYPAcRKP3i5dZaBP2Ik/l/1kTgiaAbCFU4hd88aSIa1vI0yi/WLhdZX0TatqIHEL
         Ohd2yIQrXnrlPPwTk0eNtLhAOC2eckPFlmi3I+H7U8K/VXxvniSwKGMWdSEPVcAZo1GB
         rmait42/+HQSV4VoOTPS+fC15qUMuaKoFyWoWuECuLO3kBODbmkCjaoH4hfdbjSCJ/xq
         YkdO/3T/IJ5PLTvyDQhZpmNo7/1/DvQOlj3crbXfEIkpIjTeGo2pKTnrxXszqdePmVab
         NSAw==
X-Gm-Message-State: APjAAAWO0tBXBHnKPhxM52oYjLL5G39tfKkUhYdRPHGuUX73gPfVDEaD
        aRwydmrWdsRrXEZFOn/AJnNXXEGMseU=
X-Google-Smtp-Source: APXvYqyd47e6VGbCsfK6/wnTsbb02SJUgww9Kh6MP/CS8VwVFzgeOGkH9b3RN1YLwQqUiIt9/wJRhQ==
X-Received: by 2002:ac8:1489:: with SMTP id l9mr2806409qtj.267.1552393943915;
        Tue, 12 Mar 2019 05:32:23 -0700 (PDT)
Received: from jfdmac.sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id r47sm5376907qtc.48.2019.03.12.05.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 05:32:23 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2] iio: dac: mcp4725: add missing powerdown bits in store
 eeprom
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
In-Reply-To: <20190311114239.30512-1-jeff.dagenais@gmail.com>
Date:   Tue, 12 Mar 2019 08:32:22 -0400
Cc:     jic23@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <15603225-C392-42AE-92A1-893BB7C322E3@gmail.com>
References: <20190311114239.30512-1-jeff.dagenais@gmail.com>
To:     linux-iio@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> On Mar 11, 2019, at 07:42, Jean-Francois Dagenais =
<jeff.dagenais@gmail.com> wrote:
>=20
> When issuing the write DAC register and write eeprom command, the two
> powerdown bits (PD0 and PD1) are assumed by the chip to be present in
> the bytes sent. Leaving them at 0 implies "powerdown disabled" which =
is
> a different state that the current one. By adding the current state of
> the powerdown in the i2c write, the chip will correctly power-on =
exactly
> like as it is at the moment of store_eeprom call.
>=20
> This is documented in MCP4725's datasheet, FIGURE 6-2: "Write Commands
> for DAC Input Register and EEPROM" and MCP4726's datasheet, FIGURE =
6-3:
> "Write All Memory Command".
>=20
> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> ---

I forgot to add:

Acked-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>

in v2

v3 just for that?=
