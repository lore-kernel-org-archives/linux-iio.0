Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lee.jones@linaro.org
Subject: bugfix magnetometer output registers 
Date: Tue, 24 Sep 2013 16:51:33 +0200
Message-Id: <1380034294-22887-1-git-send-email-denis.ciocca@st.com>
List-ID: <linux-iio@vger.kernel.org>

Hi,

there is a bug inside magnetometer output default registers,
the output data must be big endian and start from different address.

Thanks,
Denis
