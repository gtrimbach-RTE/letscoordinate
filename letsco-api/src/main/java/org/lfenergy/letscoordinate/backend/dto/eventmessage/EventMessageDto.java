/*
 * Copyright (c) 2018-2020, RTE (https://www.rte-france.com)
 * Copyright (c) 2019-2020 RTE international (https://www.rte-international.com)
 * See AUTHORS.txt
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 * SPDX-License-Identifier: MPL-2.0
 * This file is part of the Let’s Coordinate project.
 */

package org.lfenergy.letscoordinate.backend.dto.eventmessage;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.lfenergy.letscoordinate.backend.dto.eventmessage.header.HeaderDto;
import org.lfenergy.letscoordinate.backend.dto.eventmessage.payload.PayloadDto;

@Data
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class EventMessageDto {
    private String xmlns;
    private HeaderDto header = new HeaderDto();
    private PayloadDto payload = new PayloadDto();
}
