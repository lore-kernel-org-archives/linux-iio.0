Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:45865 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751854AbdBFO0R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Feb 2017 09:26:17 -0500
Subject: Re: [PATCH v1 0/2] iio: Add parent_trigger attribute to triggers
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net
References: <1486390912-24362-1-git-send-email-benjamin.gaignard@st.com>
Cc: fabrice.gasnier@st.com, linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <ea85bd0e-90c5-ca08-172f-91d48e35f369@metafoo.de>
Date: Mon, 6 Feb 2017 15:26:12 +0100
MIME-Version: 1.0
In-Reply-To: <1486390912-24362-1-git-send-email-benjamin.gaignard@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/06/2017 03:21 PM, Benjamin Gaignard wrote:
> Thoses patches add parent_trigger attribute to IIO triggers.
> The goal is to allow triggers to use triggers like is this done for iio
> devices.
> With this patch it will be possible to chain triggers, for example
> stm32 triggers could be used as clock of an other triggers:
> echo "tim1_trgo" > trigger0/parent_trigger.

Can you explain how this is different to assigning the parent_trigger
directly to the device?

