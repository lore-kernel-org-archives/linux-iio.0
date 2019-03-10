Return-Path: <SRS0=Fqd7=RN=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D86CC43381
	for <linux-iio@archiver.kernel.org>; Sun, 10 Mar 2019 09:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269572086A
	for <linux-iio@archiver.kernel.org>; Sun, 10 Mar 2019 09:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552211422;
	bh=idXxenPyVwi4iYaBiFolBLv2qDdG1DHHDRG3yh0OR0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DW2LDqxRtzB6eEf6WPLKhNxIn/iFrfAUmyesIZe3uJWb8pD7EG/uk3HL0vaOI7P1+
	 OHr95kd8TdU3CICdDhGXoIiroLCgUXUwQzkh/7NN/72/42k21RozbkBI01qgF06Ik9
	 LjuIqD9LHBnW/kPmz+DNMI1BIxCMWL5AE4VlTW/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbfCJJuV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 10 Mar 2019 05:50:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfCJJuV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Mar 2019 05:50:21 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8D1520657;
        Sun, 10 Mar 2019 09:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552211420;
        bh=idXxenPyVwi4iYaBiFolBLv2qDdG1DHHDRG3yh0OR0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0zKj1VKOxA71p+lPaRR4YrWEuTgJqEfibm9jWdXdEWrSuPl9In4Fc9Nqf7dIX4uee
         JB191YMkrt1506rkRZMxk3hElKZ7iH1v1yCfqnKQKfmOkE0Wi7lQWB6PzddC+sw7pJ
         zdkdaZeItnfCDrEkkUR3uSC8646nycXCc2Zr8z1o=
Date:   Sun, 10 Mar 2019 09:50:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Patrick Havelange <patrick.havelange@essensium.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/4] dt-bindings: iio/temperature: Add doc for
 thermocouple-type
Message-ID: <20190310095014.498d198c@archlinux>
In-Reply-To: <20190307103409.24174-2-patrick.havelange@essensium.com>
References: <20190307103409.24174-1-patrick.havelange@essensium.com>
        <20190307103409.24174-2-patrick.havelange@essensium.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  7 Mar 2019 11:34:07 +0100
Patrick Havelange <patrick.havelange@essensium.com> wrote:

> This explains the new generic property "thermocouple-type" that
> can be used with temperature sensors.
> 
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
I'm happy with this, but want to allow time for Rob and other
devicetree types to have a look at it as well.

Give me a poke if this is looking unloved in a week or so.

Thanks,

Jonathan

> ---
> Changes v6
>  - Add this file
> ---
>  .../bindings/iio/temperature/temperature-bindings.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt b/Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt
> new file mode 100644
> index 000000000000..69a6441d8083
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt
> @@ -0,0 +1,11 @@
> +If the temperature sensor device can be configured to use some specific
> +thermocouple type, you can use the defined types provided in the file
> +"include/dt-bindings/iio/temperature/thermocouple.h".
> +
> +Optional property:
> +thermocouple-type:	The type of the thermocouple used by the device.
> +
> +For example:
> +	device {
> +		thermocouple-type = <THERMOCOUPLE_TYPE_K> ;
> +	};

